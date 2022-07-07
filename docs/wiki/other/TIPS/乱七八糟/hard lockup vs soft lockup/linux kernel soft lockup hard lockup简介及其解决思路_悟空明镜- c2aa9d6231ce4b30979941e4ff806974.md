---
title: linux_kernel_soft_lockup_hard_lockup简介及其解决思路_悟空明镜-_c2aa9d6231ce4b30979941e4ff806974
---

# linux kernel soft lockup/hard lockup简介及其解决思路_悟空明镜-CSDN博客_config_softlockup_detector

[https://blog.csdn.net/wukongmingjing/article/details/82870807](https://blog.csdn.net/wukongmingjing/article/details/82870807)

最近有一个朋友问到我一个kernel panic问题.由于不是做这方面的,但是了解下和其解决思路还是有必要的.

## 一 概述

在linux kernel里，有一个debug选项CONFIG_HARDLOCKUP_DETECTOR。使能它可以打开kernel中的soft lockup和hard lockup探测。这两个东西到底有什么用处那？首先，soft/hard lockup的实现在kernel/watchdog.c中，主体涉及到了3个东西：kernel线程，时钟中断，NMI中断（不可屏蔽中断）。这3个东西具有不一样的优先级，依次是kernel线程 < 时钟中断 < NMI中断。而正是用到了他们之间优先级的区别，所以才可以调试系统运行中的两种问题：

- 由于某种原因导致系统处于内核态超过20s导致进程无法运行(soft lockup)
- 由于某种原因导致系统处于内核态超过10s导致中断无法运行(hard lockup)

下面是kernel document对这两者的简介:

- A ‘softlockup’ is defined as a bug that causes the kernel to loop in kernel mode for more than 20 seconds (see “Implementation” below for details), without giving other tasks a chance to run. The current stack trace is displayed upon detection and, by default, the system will stay locked up. Alternatively, the kernel can be configured to panic; a sysctl, “kernel.softlockup_panic”, a kernel parameter,“softlockup_panic” (see “Documentation/kernel-parameters.txt” for details), and a compile option,“BOOTPARAM_SOFTLOCKUP_PANIC”, are provided for this.
- A ‘hardlockup’ is defined as a bug that causes the CPU to loop in kernel mode for more than 10 seconds (see “Implementation” below for details), without letting other interrupts have a chance to run. Similarly to the softlockup case, the current stack trace is displayed upon detection and the system will stay locked up unless the default behavior is changed, which can be done through a sysctl, ‘hardlockup_panic’, a compile time knob,“BOOTPARAM_HARDLOCKUP_PANIC”, and a kernel parameter, “nmi_watchdog”

具体可以参考: Document/lockup-watchdogs.txt:[https://elixir.bootlin.com/linux/latest/source/Documentation/lockup-watchdogs.txt](https://elixir.bootlin.com/linux/latest/source/Documentation/lockup-watchdogs.txt)

## 二 soft lockup简介

接下来我们从具体代码入手分析linux(4.4.83)是如何实现这两种lockup的探测的：

```
static struct smp_hotplug_thread watchdog_threads = {  
    .store          = &softlockup_watchdog,  
    .thread_should_run  = watchdog_should_run,  
    .thread_fn      = watchdog,  
    .thread_comm        = "watchdog/%u",  
    .setup          = watchdog_enable,  
    .cleanup        = watchdog_cleanup,  
    .park           = watchdog_disable,  
    .unpark         = watchdog_enable,  
};  
  
void __init lockup_detector_init(void)  
{   /*获取采用周期*/
    set_sample_period();  
  
#ifdef CONFIG_NO_HZ_FULL  
    if (tick_nohz_full_enabled()) {  
        pr_info("Disabling watchdog on nohz_full cores by default\n");  
        cpumask_copy(&watchdog_cpumask, housekeeping_mask);  
    } else  
        cpumask_copy(&watchdog_cpumask, cpu_possible_mask);  
#else  
    cpumask_copy(&watchdog_cpumask, cpu_possible_mask);  
#endif  
    /*在系统初始化的时候,为每个online cpu创建watch_threads线程信息.*/
    if (watchdog_enabled)  
        watchdog_enable_all_cpus();  
}  
  
static int watchdog_enable_all_cpus(void)  
{  
    int err = 0;  
  
    if (!watchdog_running) { 
        /*初始化的时候,创建watchdog线程,同时关联percpu 
              watchdog_cpumask=cpu_possible_mask*/ 
        err = smpboot_register_percpu_thread_cpumask(&watchdog_threads,  
                                 &watchdog_cpumask);  
        if (err)  
            pr_err("Failed to create watchdog threads, disabled\n");  
        else  
            watchdog_running = 1;  
    } else {  
        /* 
         * Enable/disable the lockup detectors or 
         * change the sample period 'on the fly'. 
         */  
        err = update_watchdog_all_cpus();  
  
        if (err) {  
            watchdog_disable_all_cpus();  
            pr_err("Failed to update lockup detectors, disabled\n");  
        }  
    }  
  
    if (err)  
        watchdog_enabled = 0;  
  
    return err;  
}  
  
/** 
 * smpboot_register_percpu_thread_cpumask - Register a per_cpu thread related 
 *                      to hotplug 
 * @plug_thread:    Hotplug thread descriptor 
 * @cpumask:        The cpumask where threads run 
 * 
 * Creates and starts the threads on all online cpus. 
 */  
int smpboot_register_percpu_thread_cpumask(struct smp_hotplug_thread *plug_thread,  
                       const struct cpumask *cpumask)  
{  
    unsigned int cpu;  
    int ret = 0;  
  
    if (!alloc_cpumask_var(&plug_thread->cpumask, GFP_KERNEL))  
        return -ENOMEM;  
    cpumask_copy(plug_thread->cpumask, cpumask);  
  
    get_online_cpus();  
    mutex_lock(&smpboot_threads_lock);  
    for_each_online_cpu(cpu) {  
        ret = __smpboot_create_thread(plug_thread, cpu);  
        if (ret) {  
            smpboot_destroy_threads(plug_thread);  
            free_cpumask_var(plug_thread->cpumask);  
            goto out;  
        }  
        if (cpumask_test_cpu(cpu, cpumask))  
            smpboot_unpark_thread(plug_thread, cpu);  
    }  
    list_add(&plug_thread->list, &hotplug_threads);  
out:  
    mutex_unlock(&smpboot_threads_lock);  
    put_online_cpus();  
    return ret;  
}  

```

实际的逻辑如下:首先，系统会为每个cpu core注册一个一般的kernel线程，名字叫watchdog/0, watchdog/1…以此类推。这个线程会定期得调用watchdog函数

```
static DEFINE_PER_CPU(unsigned long, soft_lockup_hrtimer_cnt);  
static DEFINE_PER_CPU(unsigned long, watchdog_touch_ts);  
static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts);  
  
/* 
 * The watchdog thread function - touches the timestamp. 
 * 
 * It only runs once every sample_period seconds (4 seconds by 
 * default) to reset the softlockup timestamp. If this gets delayed 
 * for more than 2*watchdog_thresh seconds then the debug-printout 
 * triggers in watchdog_timer_fn(). 
 */  
static void watchdog(unsigned int cpu)  
{   /*将变量hrtimer_interrupts数值赋值给 soft_lockup_hrtimer_cnt*/
    __this_cpu_write(soft_lockup_hrtimer_cnt,  
             __this_cpu_read(hrtimer_interrupts));  
    __touch_watchdog();  
  
    /* 
     * watchdog_nmi_enable() clears the NMI_WATCHDOG_ENABLED bit in the 
     * failure path. Check for failures that can occur asynchronously - 
     * for example, when CPUs are on-lined - and shut down the hardware 
     * perf event on each CPU accordingly. 
     * 
     * The only non-obvious place this bit can be cleared is through 
     * watchdog_nmi_enable(), so a pr_info() is placed there.  Placing a 
     * pr_info here would be too noisy as it would result in a message 
     * every few seconds if the hardlockup was disabled but the softlockup 
     * enabled. 
     */  
    if (!(watchdog_enabled & NMI_WATCHDOG_ENABLED))  
        watchdog_nmi_disable(cpu);  
}  
  
  
/* Commands for resetting the watchdog */  
static void __touch_watchdog(void)  
{  /*获取当前时间并赋值给watchdog_touch_ts,目的是周期性的检测是否是soft_lockup*/
    __this_cpu_write(watchdog_touch_ts, get_timestamp());  
}
/*watdog函数更新watchdog_touch_ts时间戳,在哪里被调用呢?*/
/** 
 * smpboot_thread_fn - percpu hotplug thread loop function 
 * @data:   thread data pointer 
 * 
 * Checks for thread stop and park conditions. Calls the necessary 
 * setup, cleanup, park and unpark functions for the registered 
 * thread. 
 * 
 * Returns 1 when the thread should exit, 0 otherwise. 
 */  
static int smpboot_thread_fn(void *data)  
{  
    struct smpboot_thread_data *td = data;  
    struct smp_hotplug_thread *ht = td->ht;  
  
    while (1) {  
        set_current_state(TASK_INTERRUPTIBLE);  
        preempt_disable();  
  
        if (!ht->thread_should_run(td->cpu)) {  
            preempt_enable_no_resched();  
            schedule();  
        } else {  
            __set_current_state(TASK_RUNNING);  
            preempt_enable();
            /*在这里被call,在init时,为每个online cpu关联watchdog_threads结构体信息
           的时候被调用到.smpboot_register_percpu_thread_cpumask*/  
            ht->thread_fn(td->cpu);  
        }  
    }  
}  
  

```

我们先不理会这个线程处理函数watchdog多久被调用一次，我们就先简单的认为，这个线程是负责更新watchdog_touch_ts的。然后我们要看一下时钟中断了：

```
static void watchdog_enable(unsigned int cpu)  
{  /*static DEFINE_PER_CPU(struct hrtimer, watchdog_hrtimer)*/
    struct hrtimer *hrtimer = raw_cpu_ptr(&watchdog_hrtimer);  
  
    /* kick off the timer for the hardlockup detector */  
    hrtimer_init(hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);  
    /*将时钟中断函数赋值给hrtimer callback function*/
    hrtimer->function = watchdog_timer_fn;  
  
    /* Enable the perf event */  
    watchdog_nmi_enable(cpu);  
  
    /* done here because hrtimer_start can only pin to smp_processor_id() 在当前cpu上以周期sample_period运行*/  
    hrtimer_start(hrtimer, ns_to_ktime(sample_period),  
              HRTIMER_MODE_REL_PINNED);  
  
    /* initialize timestamp 设置watchdog线程的优先级为RT线程,优先级
    为prio:99*/  
    watchdog_set_prio(SCHED_FIFO, MAX_RT_PRIO - 1);  
    __touch_watchdog();  
}
/*下面是计算sample_period=4s*/
static u64 __read_mostly sample_period;  
int __read_mostly watchdog_thresh = 10;  
/* 
 * Hard-lockup warnings should be triggered after just a few seconds. Soft- 
 * lockups can have false positives under extreme conditions. So we generally 
 * want a higher threshold for soft lockups than for hard lockups. So we couple 
 * the thresholds with a factor: we make the soft threshold twice the amount of 
 * time the hard threshold is. 
 */  
static int get_softlockup_thresh(void)  
{  
    return watchdog_thresh * 2;  /*20s*/
}  
  
/* 
 * Returns seconds, approximately.  We don't need nanosecond 
 * resolution, and we don't need to waste time with a big divide when 
 * 2^30ns == 1.074s. 
 */  
static unsigned long get_timestamp(void)  
{  
    return running_clock() >> 30LL;  /* 2^30 ~= 10^9 */  
}  
  
static void set_sample_period(void)  
{  
    /* 
     * convert watchdog_thresh from seconds to ns 
     * the divide by 5 is to give hrtimer several chances (two 
     * or three with the current relation between the soft 
     * and hard thresholds) to increment before the 
     * hardlockup detector generates a warning 
     */  
    sample_period = get_softlockup_thresh() * ((u64)NSEC_PER_SEC / 5);  
}  

```

时钟中断处理函数是watchdog_timer_fn(注意关键字:HRTIMER_RESTART,会周期性的执行.):

```
/* watchdog kicker functions */  
static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)  
{   /*获取执行函数watchdog时候更新watchdog_touch_ts时间戳*/
    unsigned long touch_ts = __this_cpu_read(watchdog_touch_ts);  
    struct pt_regs *regs = get_irq_regs();  
    int duration;  
    int softlockup_all_cpu_backtrace = sysctl_softlockup_all_cpu_backtrace;  
    
    /* kick the hardlockup detector */  
    watchdog_interrupt_count();  
  
    /* test for hardlockups on the next cpu */  
    watchdog_check_hardlockup_other_cpu();  
  
    /* kick the softlockup detector */  
    wake_up_process(__this_cpu_read(softlockup_watchdog));  
  
    /* .. and repeat */  
    hrtimer_forward_now(hrtimer, ns_to_ktime(sample_period));  
    /*第一次执行,watchdog_touch_ts时间戳可能为零,需要更新touch_ts
    为当前时间戳*/
    if (touch_ts == 0) {  
        if (unlikely(__this_cpu_read(softlockup_touch_sync))) {  
            /* 
             * If the time stamp was touched atomically 
             * make sure the scheduler tick is up to date. 
             */  
            __this_cpu_write(softlockup_touch_sync, false);  
            sched_clock_tick();  
        }  
  
        /* Clear the guest paused flag on watchdog reset */  
        kvm_check_and_clear_guest_paused();  
        __touch_watchdog();  
        return HRTIMER_RESTART;  
    }  
  
    /* check for a softlockup 
     * This is done by making sure a high priority task is 
     * being scheduled.  The task touches the watchdog to 
     * indicate it is getting cpu time.  If it hasn't then 
     * this is a good indication some task is hogging the cpu 
     */ /*检测系统是否处于内核mode超过20s,并做出决策*/ 
    duration = is_softlockup(touch_ts);  
    if (unlikely(duration)) {  
        /* 
         * If a virtual machine is stopped by the host it can look to 
         * the watchdog like a soft lockup, check to see if the host 
         * stopped the vm before we issue the warning 
         */  
        if (kvm_check_and_clear_guest_paused())  
            return HRTIMER_RESTART;  
  
        /* only warn once */  
        if (__this_cpu_read(soft_watchdog_warn) == true) {  
            /* 
             * When multiple processes are causing softlockups the 
             * softlockup detector only warns on the first one 
             * because the code relies on a full quiet cycle to 
             * re-arm.  The second process prevents the quiet cycle 
             * and never gets reported.  Use task pointers to detect 
             * this. 
             */  
            if (__this_cpu_read(softlockup_task_ptr_saved) !=  
                current) {  
                __this_cpu_write(soft_watchdog_warn, false);  
                __touch_watchdog();  
            }  
            return HRTIMER_RESTART;  
        }  
  
        if (softlockup_all_cpu_backtrace) {  
            /* Prevent multiple soft-lockup reports if one cpu is already 
             * engaged in dumping cpu back traces 
             */  
            if (test_and_set_bit(0, &soft_lockup_nmi_warn)) {  
                /* Someone else will report us. Let's give up */  
                __this_cpu_write(soft_watchdog_warn, true);  
                return HRTIMER_RESTART;  
            }  
        }  
        /*上面是一些条件的判断是否是真正的soft_lockup.下面是当soft_lockup出现的话会将
     一些必要的信息dump出来.*/
        pr_emerg("BUG: soft lockup - CPU#%d stuck for %us! [%s:%d]\n",  
            smp_processor_id(), duration,  
            current->comm, task_pid_nr(current));  
        __this_cpu_write(softlockup_task_ptr_saved, current);  
        print_modules();  
        print_irqtrace_events(current);  
        if (regs)  
            show_regs(regs);  
        else  
            dump_stack();  
  
        if (softlockup_all_cpu_backtrace) {  
            /* Avoid generating two back traces for current 
             * given that one is already made above 
             */  
            trigger_allbutself_cpu_backtrace();  
  
            clear_bit(0, &soft_lockup_nmi_warn);  
            /* Barrier to sync with other cpus */  
            smp_mb__after_atomic();  
        }  
  
        add_taint(TAINT_SOFTLOCKUP, LOCKDEP_STILL_OK);  
        if (softlockup_panic)  
            panic("softlockup: hung tasks");  
        __this_cpu_write(soft_watchdog_warn, true);  
    } else  
        __this_cpu_write(soft_watchdog_warn, false);  
  
    return HRTIMER_RESTART;  
}  

```

watchdog_timer_fn这个函数的目的如下:

- watchdog_interrupt_count函数更新hrtimer_interrupts变量

```
static void watchdog_interrupt_count(void)  
{  
    __this_cpu_inc(hrtimer_interrupts);  
}  

```

- is_softlockup判断是否出现了soft_lockup

```
static int is_softlockup(unsigned long touch_ts)  
{  
    unsigned long now = get_timestamp();  
  
    if ((watchdog_enabled & SOFT_WATCHDOG_ENABLED) && watchdog_thresh){  
        /* Warn about unreasonable delays. */  
        if (time_after(now, touch_ts + get_softlockup_thresh()))  
            return now - touch_ts;  
    }  
    return 0;  
}  

```

很容易理解，其实就是查看watchdog_touch_ts变量在最近20秒的时间内，有没有被创建的kernel thread(即watchdog函数有没有在某个cpu上超过20s没有执行过来更新watchdog_touch_ts变量)更新过。假如没有，那就意味着线程得不到调度，所以很有可能就是系统处于内核态太久了，导致调度器没有办法进行调度。这种情况下，系统往往不会死掉，但是会很慢。有了soft lockup的机制，我们就能尽早的发现这样的问题了。

## 三 hard lockup简介

我们接着分析hard lockup

```
static int watchdog_nmi_enable(unsigned int cpu)  
{  
    struct perf_event_attr *wd_attr;  
    struct perf_event *event = per_cpu(watchdog_ev, cpu);  
  
    /* nothing to do if the hard lockup detector is disabled */  
    if (!(watchdog_enabled & NMI_WATCHDOG_ENABLED))  
        goto out;  
  
    /* is it already setup and enabled? */  
    if (event && event->state > PERF_EVENT_STATE_OFF)  
        goto out;  
  
    /* it is setup but not enabled */  
    if (event != NULL)  
        goto out_enable;  
  
    wd_attr = &wd_hw_attr;
   /*获取hard lockup周期性检测的时间*/  
    wd_attr->sample_period = hw_nmi_get_sample_period(watchdog_thresh);  
    /* 通过HW event,即通过NMI将信号发送给cpu来处理hard lockup.核心函数watchdog_ov
   erflow_callback */
    /* Try to register using hardware perf events */  
    event = perf_event_create_kernel_counter(wd_attr, cpu, NULL, watchdog_overflow_callback, NULL);  
  
    /* save cpu0 error for future comparision */  
    if (cpu == 0 && IS_ERR(event))  
        cpu0_err = PTR_ERR(event);  
  
    if (!IS_ERR(event)) {  
        /* only print for cpu0 or different than cpu0 */  
        if (cpu == 0 || cpu0_err)  
            pr_info("enabled on all CPUs, permanently consumes one hw-PMU counter.\n");  
        goto out_save;  
    }  
  
    /* 
     * Disable the hard lockup detector if _any_ CPU fails to set up 
     * set up the hardware perf event. The watchdog() function checks 
     * the NMI_WATCHDOG_ENABLED bit periodically. 
     * 
     * The barriers are for syncing up watchdog_enabled across all the 
     * cpus, as clear_bit() does not use barriers. 
     */  
    smp_mb__before_atomic();  
    clear_bit(NMI_WATCHDOG_ENABLED_BIT, &watchdog_enabled);  
    smp_mb__after_atomic();  
  
    /* skip displaying the same error again */  
    if (cpu > 0 && (PTR_ERR(event) == cpu0_err))  
        return PTR_ERR(event);  
  
    /* vary the KERN level based on the returned errno */  
    if (PTR_ERR(event) == -EOPNOTSUPP)  
        pr_info("disabled (cpu%i): not supported (no LAPIC?)\n", cpu);  
    else if (PTR_ERR(event) == -ENOENT)  
        pr_warn("disabled (cpu%i): hardware events not enabled\n",  
             cpu);  
    else  
        pr_err("disabled (cpu%i): unable to create perf event: %ld\n",  
            cpu, PTR_ERR(event));  
  
    pr_info("Shutting down hard lockup detector on all cpus\n");  
  
    return PTR_ERR(event);  
  
    /* success path */  
out_save:  
    per_cpu(watchdog_ev, cpu) = event;  
out_enable:  
    perf_event_enable(per_cpu(watchdog_ev, cpu));  
out:  
    return 0;  
}  

```

perf_event_create_kernel_counter函数主要是注册了一个硬件的事件。这个硬件在x86里叫performance monitoring，这个硬件有一个功能就是在cpu clock经过了多少个周期后发出一个NMI中断出来。 核心函数分析:

```
#ifdef CONFIG_HARDLOCKUP_DETECTOR_NMI  
  
static struct perf_event_attr wd_hw_attr = {  
    .type       = PERF_TYPE_HARDWARE,  
    .config     = PERF_COUNT_HW_CPU_CYCLES,  
    .size       = sizeof(struct perf_event_attr),  
    .pinned     = 1,  
    .disabled   = 1,  
};  
  
/* Callback function for perf event subsystem */  
static void watchdog_overflow_callback(struct perf_event *event,  
         struct perf_sample_data *data,  
         struct pt_regs *regs)  
{  
    /* Ensure the watchdog never gets throttled */  
    event->hw.interrupts = 0;  
  
    if (__this_cpu_read(watchdog_nmi_touch) == true) {  
        __this_cpu_write(watchdog_nmi_touch, false);  
        return;  
    }  
  
    /* check for a hardlockup 
     * This is done by making sure our timer interrupt 
     * is incrementing.  The timer interrupt should have 
     * fired multiple times before we overflow'd.  If it hasn't 
     * then this is a good indication the cpu is stuck 
     *//*hrtimer_interrupts_saved上次保存的数值与当前hrtimer_interrupts是否有差异
     */  
    if (is_hardlockup()) {  
        int this_cpu = smp_processor_id();  
  
        /* only print hardlockups once */  
        if (__this_cpu_read(hard_watchdog_warn) == true)  
            return;  
  
        pr_emerg("Watchdog detected hard LOCKUP on cpu %d", this_cpu);  
        print_modules();  
        print_irqtrace_events(current);  
        if (regs)  
            show_regs(regs);  
        else  
            dump_stack();  
  
        /* 
         * Perform all-CPU dump only once to avoid multiple hardlockups 
         * generating interleaving traces 
         */  
        if (sysctl_hardlockup_all_cpu_backtrace &&  
                !test_and_set_bit(0, &hardlockup_allcpu_dumped))  
            trigger_allbutself_cpu_backtrace();  
  
        if (hardlockup_panic)  
            panic("Hard LOCKUP");  
  
        __this_cpu_write(hard_watchdog_warn, true);  
        return;  
    }  
  
    __this_cpu_write(hard_watchdog_warn, false);  
    return;  
}  
#endif /* CONFIG_HARDLOCKUP_DETECTOR_NMI */ 
 
#ifdef CONFIG_HARDLOCKUP_DETECTOR_NMI  
/* watchdog detector functions */  
static bool is_hardlockup(void)  
{  
    unsigned long hrint = __this_cpu_read(hrtimer_interrupts);  
  
    if (__this_cpu_read(hrtimer_interrupts_saved) == hrint)  
        return true;  
  
    __this_cpu_write(hrtimer_interrupts_saved, hrint);  
    return false;  
}  
#endif  

```

而这个函数主要就是查看hrtimer_interrupts变量在时钟中断处理函数里有没有被更新。假如没有更新，就意味着中断出了问题，可能被错误代码长时间的关中断了。那这样，相应的问题也就暴露出来了。

## 四 案例分析

出现panic的dmesg信息如下:

```
[5561883.978551] NMI watchdog: Watchdog detected hard LOCKUP on cpu 15  
[5561883.978593] Modules linked in:  
[5561883.978598]  dm_mod sctp_diag sctp dccp_diag dccp tcp_diag udp_diag inet_diag unix_diag af_packet_diag netlink_diag iptable_filter binfmt_misc bonding skx_edac edac_core intel_powerclamp coretemp intel_rapl iTCO_wdt iosf_mbi kvm_intel iTCO_vendor_support kvm dcdbas irqbypass crc32_pclmul ghash_clmulni_intel aesni_intel lrw gf128mul glue_helper ablk_helper cryptd sg ipmi_ssif pcspkr ipmi_si shpchp ipmi_devintf mei_me ipmi_msghandler mei lpc_ich nfit i2c_i801 libnvdimm acpi_power_meter acpi_pad ip_tables xfs libcrc32c sd_mod crc_t10dif crct10dif_generic mgag200 i2c_algo_bit drm_kms_helper crct10dif_pclmul syscopyarea crct10dif_common sysfillrect crc32c_intel sysimgblt fb_sys_fops ttm i40e drm ahci libahci tg3 libata megaraid_sas ptp i2c_core pps_core  
[5561883.978652] CPU: 15 PID: 0 Comm: swapper/15 Not tainted 3.10.0-693.el7.x86_64 #1  
[5561883.978654] Hardware name: Dell Inc. PowerEdge R540/0NJK2F, BIOS 1.3.7 02/09/2018  
[5561883.978657] task: ffff88289bb1bf40 ti: ffff88289bb90000 task.ti: ffff88289bb90000  
[5561883.978659] RIP: 0010:[<ffffffff810bf107>]  [<ffffffff810bf107>] finish_task_switch+0x57/0x160  
[5561883.978671] RSP: 0000:ffff88289bb93e48  EFLAGS: 00000286  
[5561883.978672] RAX: ffff882899e0dee0 RBX: ffffffff810b4155 RCX: 0000000000000000  
[5561883.978673] RDX: ffff88289bb91fd8 RSI: ffff88289bb1bf40 RDI: ffff883fdbfd6cc0  
[5561883.978675] RBP: ffff88289bb93e68 R08: ffff88289bb90000 R09: 0000000000000002  
[5561883.978676] R10: 000000000000000f R11: 0000000000000000 R12: ffff883fdbfcfe80  
[5561883.978677] R13: ffff883fdbfcf960 R14: ffffffff8132bfe0 R15: ffff88289bb93db8  
[5561883.978679] FS:  0000000000000000(0000) GS:ffff883fdbfc0000(0000) knlGS:0000000000000000  
[5561883.978680] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033  
[5561883.978682] CR2: 00007f3fe8b4aff8 CR3: 00000004981d8000 CR4: 00000000003407e0  
[5561883.978683] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000  
[5561883.978684] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400  
[5561883.978685] Stack:  
[5561883.978686]  0000000000000000 ffff883fdbfd6cc0 ffff88026b7ce400 0000000000000000  
[5561883.978689]  ffff88289bb93ec8 ffffffff816a8f8d ffff88289bb1bf40 ffff88289bb93fd8  
[5561883.978691]  ffff88289bb93fd8 ffff88289bb93fd8 ffff88289bb1bf40 ffffffff81b1c820  
[5561883.978694] Call Trace:  
[5561883.978700]  [<ffffffff816a8f8d>] __schedule+0x39d/0x8b0  
[5561883.978703]  [<ffffffff816aa3e9>] schedule_preempt_disabled+0x29/0x70  
[5561883.978710]  [<ffffffff810e7c0a>] cpu_startup_entry+0x18a/0x1c0  
[5561883.978715]  [<ffffffff81051af6>] start_secondary+0x1b6/0x230  
[5561883.978717] Code: 1f 44 00 00 65 48 8b 34 25 00 ce 00 00 0f 1f 44 00 00 41 c7 45 28 00 00 00 00 48 89 df c6 07 00 0f 1f 40 00 fb 66 0f 1f 44 00 00 <65> 48 8b 04 25 00 ce 00 00 48 8b 98 78 01 00 00 48 85 db 74 1c  
[5561883.978741] Kernel panic - not syncing: Hard LOCKUP  
[5561883.978767] CPU: 15 PID: 0 Comm: swapper/15 Not tainted 3.10.0-693.el7.x86_64 #1  
[5561883.978802] Hardware name: Dell Inc. PowerEdge R540/0NJK2F, BIOS 1.3.7 02/09/2018  
[5561883.978837]  ffff88289bb93d00 d5511a25db39e950 ffff883fdbfc5b18 ffffffff816a3d91  
[5561883.978879]  ffff883fdbfc5b98 ffffffff8169dc54 0000000000000010 ffff883fdbfc5ba8  
[5561883.978923]  ffff883fdbfc5b48 d5511a25db39e950 0000000000000000 ffffffff8190ac0f  
[5561883.978966] Call Trace:  
[5561883.978980]  <NMI>  [<ffffffff816a3d91>] dump_stack+0x19/0x1b  
[5561883.979019]  [<ffffffff8169dc54>] panic+0xe8/0x20d  
[5561883.979046]  [<ffffffff8108771f>] nmi_panic+0x3f/0x40  
[5561883.979073]  [<ffffffff8112fa75>] watchdog_overflow_callback+0xf5/0x100  
[5561883.979108]  [<ffffffff8116e561>] __perf_event_overflow+0x51/0xf0  
[5561883.979139]  [<ffffffff811770b4>] perf_event_overflow+0x14/0x20  
[5561883.979170]  [<ffffffff81009f78>] intel_pmu_handle_irq+0x218/0x4f0  
[5561883.979204]  [<ffffffff81324abc>] ? ioremap_page_range+0x26c/0x3d0  
[5561883.979236]  [<ffffffff811c0a04>] ? vunmap_page_range+0x1b4/0x300  
[5561883.979266]  [<ffffffff811c0b61>] ? unmap_kernel_range_noflush+0x11/0x20  
[5561883.979300]  [<ffffffff813da15e>] ? ghes_copy_tofrom_phys+0x10e/0x210  
[5561883.979332]  [<ffffffff813da300>] ? ghes_read_estatus+0xa0/0x190  
[5561883.979363]  [<ffffffff816ac06b>] perf_event_nmi_handler+0x2b/0x50  
[5561883.979394]  [<ffffffff816ad427>] nmi_handle.isra.0+0x87/0x160  
[5561883.979424]  [<ffffffff816ad710>] do_nmi+0x210/0x450  
[5561883.979451]  [<ffffffff810c89b0>] ? task_scan_max+0x40/0x40  
[5561883.979480]  [<ffffffff816ac8d3>] end_repeat_nmi+0x1e/0x2e  
[5561883.979508]  [<ffffffff810c89b0>] ? task_scan_max+0x40/0x40  
[5561883.979536]  [<ffffffff810c89ce>] ? tg_unthrottle_up+0x1e/0x50  
[5561883.979566]  [<ffffffff810c89ce>] ? tg_unthrottle_up+0x1e/0x50  
[5561883.979595]  [<ffffffff810c89ce>] ? tg_unthrottle_up+0x1e/0x50  
[5561883.979624]  <<EOE>>  <IRQ>  [<ffffffff810c0bcb>] walk_tg_tree_from+0x7b/0x110  
[5561883.979666]  [<ffffffff810ba190>] ? __smp_mb__after_atomic+0x10/0x10  
[5561883.979698]  [<ffffffff810d0977>] unthrottle_cfs_rq+0xb7/0x170  
[5561883.979726]  [<ffffffff810d0bfa>] distribute_cfs_runtime+0x10a/0x130  
[5561883.979759]  [<ffffffff810d0da7>] sched_cfs_period_timer+0xb7/0x150  
[5561883.979790]  [<ffffffff810d0cf0>] ? sched_cfs_slack_timer+0xd0/0xd0  
[5561883.979822]  [<ffffffff810b4ae4>] __hrtimer_run_queues+0xd4/0x260  
[5561883.979853]  [<ffffffff810b507f>] hrtimer_interrupt+0xaf/0x1d0  
[5561883.979883]  [<ffffffff81053895>] local_apic_timer_interrupt+0x35/0x60  
[5561883.979917]  [<ffffffff816b76bd>] smp_apic_timer_interrupt+0x3d/0x50  
[5561883.979949]  [<ffffffff816b5c1d>] apic_timer_interrupt+0x6d/0x80  
[5561883.979977]  <EOI>  [<ffffffff810b4155>] ? enqueue_hrtimer+0x25/0x80  
[5561883.980013]  [<ffffffff810bf107>] ? finish_task_switch+0x57/0x160  
[5561883.980044]  [<ffffffff816a8f8d>] __schedule+0x39d/0x8b0  
[5561883.980071]  [<ffffffff816aa3e9>] schedule_preempt_disabled+0x29/0x70  
[5561883.981014]  [<ffffffff810e7c0a>] cpu_startup_entry+0x18a/0x1c0  
[5561883.981889]  [<ffffffff81051af6>] start_secondary+0x1b6/0x230  

```

可以看到是hard lockup, 看dump出来的栈信息,可以基本判断是出现cfs在做unthrottle的时候出现的问题. 因为cfs检测throttle是定时中断周期性检测的,导致hard lockup hrtimer_interrupts变量长时间没有更新. 即系统在给进程重新分析调度时间的时候出现的问题. 仅仅是怀疑,没有现场和使用crash tool去debug. 后续在update.