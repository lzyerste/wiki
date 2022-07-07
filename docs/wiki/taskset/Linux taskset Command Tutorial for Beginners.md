---
title: Linux_taskset_Command_Tutorial_for_Beginners
---

# Linux taskset Command Tutorial for Beginners (with Examples)

[https://www.howtoforge.com/linux-taskset-command/](https://www.howtoforge.com/linux-taskset-command/)

![linux-taskset-command.jpg](assets/linux-taskset-command.jpg)

Ever heard of the term processor affinity? It's a feature that allows you to bind or unbind processes to a particular central processing unit, or a range of CPUs. Yes, you can tell the system which CPU core(s) should be used to run a particular process. For theoretical details on why processor affinity exists, head [here](https://en.wikipedia.org/wiki/Processor_affinity).

Here, in this tutorial, we will discuss a utility - dubbed **taskset** - that lets you achieve processor affinity. But before we do that, it's worth mentioning that all examples in this tutorial have been tested on an Ubuntu 20.04 LTS machine and on Debian 10.

## Linux taskset command

The taskset command allows you to set or retrieve a process's CPU affinity. Following is its syntax:

```
taskset [options] mask command [argument...]
taskset [options] -p [mask] pid
```

Here's how the tool's man page explains it:

```
       taskset  is  used  to  set  or  retrieve  the CPU affinity of a running
       process given its pid, or to launch a new  command  with  a  given  CPU
       affinity.   CPU affinity is a scheduler property that "bonds" a process
       to a given set of CPUs on the system.  The Linux scheduler  will  honor
       the  given CPU affinity and the process will not run on any other CPUs.
       Note that the Linux scheduler also supports natural CPU  affinity:  the
       scheduler attempts to keep processes on the same CPU as long as practi?
       cal for performance reasons.  Therefore, forcing a specific CPU  affin?
       ity is useful only in certain applications.

       The CPU affinity is represented as a bitmask, with the lowest order bit
       corresponding to the first logical CPU and the highest order bit corre?
       sponding  to  the  last logical CPU.  Not all CPUs may exist on a given
       system but a mask may specify more CPUs than are present.  A  retrieved
       mask  will  reflect only the bits that correspond to CPUs physically on
       the system.  If an invalid mask is given (i.e., one that corresponds to
       no  valid  CPUs on the current system) an error is returned.  The masks
       may be specified in hexadecimal (with or without a leading "0x"), or as
       a CPU list with the --cpu-list option.  For example,

           0x00000001  is processor #0,

           0x00000003  is processors #0 and #1,

           0xFFFFFFFF  is processors #0 through #31,

           32          is processors #1, #4, and #5,

           --cpu-list 0-2,6
                       is processors #0, #1, #2, and #6.

       When  taskset returns, it is guaranteed that the given program has been
       scheduled to a legal CPU.
```

The following are some Q&A-styled examples that should give you a better idea of how the taskset command works.

## Q1. How to use taskset to retrieve the CPU affinity of a process?

If you want taskset to display CPU affinity of an already running process, use the command in the following way:

```
taskset -p [PID]
```

Just replace PID with the ID of the process whose CPU affinity you want to fetch. For example:

```
taskset -p 9726
```

The above command returned the following output:

```
pid 9726's current affinity mask: f
```

So hexadecimal value 'f' here means the process can run on any of the 4 processor cores: 0,1,2,3.

If you want the output to be in terms of CPU range, you can add the -c command line option.

```
taskset -cp 9726
```

Following is the output in this case:

```
pid 9726's current affinity list: 0-3
```

## Q2. How to change CPU affinity using taskset?

To tweak the CPU affinity of an existing process, you need to specify the process ID (like we did in the previous section) along with a hexadecimal mask that defines the new affinity.

For example, the current CPU affinity of the Gedit process (PID: 9726) is 'f'.

To change the affinity to 0x11, use the following command:

```
taskset -p 0x11 9726
```

And then you can again check the new affinity using the following command:

```
taskset -p 9726
```

The following screenshots show the outputs for these commands in my case:

So you can see that the affinity got changed.

## Q3. How to assign a range of CPUs while changing affinity?

This is no big deal. All you have to do is to add the -c command-line option to the command we've used in the previous section along with the CPU core range as input.

Here is an example:

taskset -cp 0,3 9726

Following is the output produced in this case:

```
pid 9726's current affinity list: 0
pid 9726's new affinity list: 0,3
```

## Q4. How to launch a process with predefined CPU affinity?

Yes, you can also launch a process with a set CPU affinity.

taskset 0xa gedit

## Conclusion

Agreed, the taskset command isn't for an average command line user. It's mostly used by server-side experts for process optimization in a multi-core environment. We've discussed the tool's basics here. For more info, head to its [man page](https://linux.die.net/man/1/taskset).