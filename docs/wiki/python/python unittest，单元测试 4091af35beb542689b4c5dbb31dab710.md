---
title: python_unittest，单元测试_4091af35beb542689b4c5dbb31dab710
---

# python unittest，单元测试

```python
import subprocess
import os
import sys
from datetime import date, datetime
import re
import time
import random
import unittest
import argparse

KB = 1024
MB = 1024 ** 2
GB = 1024 ** 3
TB = 1024 ** 4

def str2bool(v):
    if isinstance(v, bool):
       return v
    if v.lower() in ('yes', 'true', 't', 'y', '1'):
        return True
    elif v.lower() in ('no', 'false', 'f', 'n', '0'):
        return False
    else:
        raise argparse.ArgumentTypeError('Boolean value expected.')

def naturalsize(s):
    G = {"kb": 1024, "mb": 1024**2, "gb": 1024**3, "tb": 1024**4,
         "pb": 1024**5, "eb": 1024**6, "zb": 1024**7, "yb": 1024**8}
    s = s.lower()
    unit = s[-2:]
    if unit in G:
        return int(s[:-2]) * G[unit]
    return int(s)

def humansize(d):
    if d == 0:
        return str(d)
    G = {"kb": 1024, "mb": 1024**2, "gb": 1024**3, "tb": 1024**4,
         "pb": 1024**5, "eb": 1024**6, "zb": 1024**7, "yb": 1024**8}
    H = list(G.items())
    H.sort(key=lambda x: x[1], reverse=True)
    for k, v in H:
        if d % v == 0:
            return "%s%s" % (d // v, k.upper())
    return str(d)

def run_cmd(cmd, echo_cmd=True, echo_stdout=True, timeout=None) -> (int, str):
    if echo_cmd:
        print("[%s] %s" % (datetime.now(), cmd))
    cmpl = subprocess.run(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, timeout=timeout, encoding="utf-8")
    if cmpl.returncode != 0:
        print("ERROR:")
        print(cmpl)
    elif echo_stdout:
        print(str(cmpl.stdout).strip())
    return cmpl.returncode, str(cmpl.stdout).strip()

def run_cmd_assert(cmd, echo_cmd=True, echo_stdout=True, timeout=None):
    r, s = run_cmd(cmd, echo_cmd, echo_stdout, timeout)
    assert(r == 0)
    return s.strip()

GIT_ROOT = run_cmd_assert("git rev-parse --show-toplevel")
RPC_SCRIPT = os.path.join(GIT_ROOT, "scripts/rpc.py")

def bdev_exists(bdev_name):
    cmd = "%s bdev_get_bdevs" % RPC_SCRIPT
    s = run_cmd_assert(cmd, echo_cmd=False, echo_stdout=False)
    return bdev_name in s

def bdev_create_malloc(bdev_name, size, block_size=4096):
    """
    example:
    scripts/rpc.py bdev_malloc_create -b Malloc0 1024 4096
    """
    if bdev_exists(bdev_name):
        print("bdev %s already exists" % bdev_name)
        return

    cmd = "%s bdev_malloc_create -b %s %d %d" % (RPC_SCRIPT, bdev_name, size, block_size)
    run_cmd_assert(cmd, timeout=60)

    if bdev_exists(bdev_name):
        print("create bdev %s succ" % bdev_name)
    else:
        print("create bdev %s failed" % bdev_name)

def bdev_delete(bdev_name):
    if bdev_exists(bdev_name):
        cmd = "%s bdev_malloc_delete %s" % (RPC_SCRIPT, bdev_name)
        run_cmd_assert(cmd, timeout=60)
    else:
        print("bdev %s does not exist" % bdev_name)
        return

    if not bdev_exists(bdev_name):
        print("delete bdev %s succ" % bdev_name)
    else:
        print("delete bdev %s failed" % bdev_name)

def bdev_num_blocks(bdev_name):
    """
    in blocks
    """
    cmd = "%s bdev_get_bdevs" % RPC_SCRIPT
    s = run_cmd_assert(cmd, timeout=5, echo_cmd=False, echo_stdout=False)
    pattern = r'"name":\s*"%s".*"num_blocks":\s*(\d+),' % bdev_name
    group = re.search(pattern, s, re.DOTALL)
    return int(group[1])

def nvme_zone_size(bdev_name):
    """
    in bytes
    """
    cmd = "%s bdev_get_bdevs" % RPC_SCRIPT
    s = run_cmd_assert(cmd, timeout=5, echo_cmd=False, echo_stdout=False)
    pattern = r'"name":\s*"%s".*"zone_size":\s*(\d+),' % bdev_name
    group = re.search(pattern, s, re.DOTALL)
    return int(group[1])

def nvme_exists(ctrlr):
    """
    example:
    [
        {
            "name": "nvme0",
            "trid": {
            "trtype": "PCIe",
            "traddr": "0000:82:00.0"
            }
        }
    ]
    """
    cmd = "%s bdev_nvme_get_controllers" % RPC_SCRIPT
    s = run_cmd_assert(cmd, echo_cmd=False, echo_stdout=False)
    pattern = r'"name":\s*"%s"' % ctrlr
    return re.search(pattern, s) is not None

def nvme_attach(ctrlr, addr, transport="pcie"):
    """
    example:
    scripts/rpc.py bdev_nvme_attach_controller -b nvme0 -a 0000:08:00.0 -t pcie
    """
    cmd = "%s bdev_nvme_attach_controller -b %s -a %s -t %s" % (RPC_SCRIPT, ctrlr, addr, transport)
    run_cmd_assert(cmd, timeout=300)

def nvme_detach(ctrlr):
    """
    example:
    scripts/rpc.py bdev_nvme_detach_controller nvme0
    """
    cmd = "%s bdev_nvme_detach_controller %s" % (RPC_SCRIPT, ctrlr)
    run_cmd_assert(cmd, timeout=300)

def workload_create():
    print("TODO")
    assert(False)

def thread_exists(thread_name):
    cmd = "%s thread_get_stats" % RPC_SCRIPT
    s = run_cmd_assert(cmd, echo_cmd=False, echo_stdout=False)
    pattern = r'"name":\s*"%s"' % thread_name
    return re.search(pattern, s) is not None

def workload_exists(workload):
    return thread_exists(workload)

def workload_wait_to_finish(workload):
    while workload_exists(workload):
        time.sleep(5)

def task_exists(task):
    return thread_exists(task)

def setup_bdev_malloc(bdev_name, size=512, block_size=4096):
    verify_filename = bdev_name + ".verify"

    if bdev_exists(bdev_name):
        bdev_delete(bdev_name)

    if os.path.exists(verify_filename):
        cmd = "rm -rf %s" % verify_filename
        run_cmd_assert(cmd, echo_stdout=False)

    bdev_create_malloc(bdev_name, size, block_size)

def cleanup_bdev_malloc(bdev_name):
    verify_filename = bdev_name + ".verify"
    bdev_delete(bdev_name)
    if os.path.exists(verify_filename):
        cmd = "rm -rf %s" % verify_filename
        run_cmd_assert(cmd)

g_bdev_name = "Malloc0"
g_ctrlr = "nvme0"
g_offset = 0
g_size = 1 * MB
g_bs = 4096  # drive block size
g_iodepth = 1
g_rw = "rw"
g_rwmixread = 50
g_runtime = 60
g_number_ios = 0
g_io_limit = 0
g_numjobs = 1
g_loops = 1
# g_max_open_zone = 4
g_fake_zns = True
g_zone_size = 1 * MB
g_zone_capacity = 1 * MB
g_bdev_size = 512  # Malloc bdev size, in MB
g_block_size = 4096  # req block size
g_backfile = "Malloc0.verify"
g_load_from_file = True
g_load_from_drive = False

GLOBAL_CFG = dict()
USER_CFG = dict()

def reset_global_cfg(G):
    global GLOBAL_CFG

    G['bdev_name'] = g_bdev_name
    G['ctrlr'] = g_ctrlr
    G['offset'] = g_offset
    G['size'] = g_size
    G['bs'] = g_bs
    G['iodepth'] = g_iodepth
    G['rw'] = g_rw
    G['rwmixread'] = g_rwmixread
    G['runtime'] = g_runtime
    G['number_ios'] = g_number_ios
    G['io_limit'] = g_io_limit
    G['numjobs'] = g_numjobs
    G['loops'] = g_loops
    # G['max_open_zones'] = g_max_open_zones
    G['fake_zns'] = g_fake_zns
    G['zone_size'] = g_zone_size
    G['zone_capacity'] = g_zone_capacity
    G['block_size'] = g_block_size
    G['bdev_size'] = g_bdev_size
    G['backfile'] = g_backfile
    G['load_from_file'] = g_load_from_file
    G['load_from_drive'] = g_load_from_drive

def update_global_cfg(G, **kwargs):
    for k, v in kwargs.items():
        if v is not None:
            G[k] = v

reset_global_cfg(GLOBAL_CFG)

class GenericTestBase(unittest.TestCase):
    def is_fake_zns(self):
        return self.params['fake_zns']

    def default_setup(self, **kwargs):
        self.params = GLOBAL_CFG.copy()
        for k, v in kwargs.items():
            if v is not None:
                self.params[k] = v

        if not self.is_fake_zns():
            self._set_zone_size(8 * GB)
            self._set_zone_capacity(4572 * MB)
            self.params['bdev_name'] = 'nvme0n1'
        else:
            self.params['bdev_name'] = 'Malloc0'

        # default workload size: one zone
        self._set_workload_size(self._get_zone_size())
        self.params['backfile'] = self.params['bdev_name'] + ".verify"

        for k, v in USER_CFG.items():
            if v is not None:
                self.params[k] = v

        if not self.is_fake_zns():
            cmd = "lspci | grep Non-Volatile | grep 5636"
            s = run_cmd_assert(cmd)
            self.addr = s.split()[0]

    def _setUpMalloc(self):
        if bdev_exists(self.params['bdev_name']):
            bdev_delete(self.params['bdev_name'])

        if os.path.exists(self.params['backfile']):
            cmd = "rm -rf %s" % self.params['backfile']
            run_cmd_assert(cmd, echo_stdout=False)

        bdev_create_malloc(self.params['bdev_name'], self.params['bdev_size'], self.params['block_size'])

    def _tearDownMalloc(self):
        # TODO: if test fails, delete workloads? keep file?
        bdev_delete(self.params['bdev_name'])
        if os.path.exists(self.params['backfile']):
            cmd = "rm -rf %s" % self.params['backfile']
            run_cmd_assert(cmd)

    def _setUpNvme(self):
        if not nvme_exists(self.params['ctrlr']):
            nvme_attach(self.params['ctrlr'], self.addr)

    def setUp(self):
        self.default_setup()

        if self.is_fake_zns():
            self._setUpMalloc()
        else:
            self._setUpNvme()

        num_blocks = bdev_num_blocks(self.params['bdev_name'])
        self._set_bdev_size(num_blocks * self.params['block_size'])

        if not self.is_fake_zns():
            # zns: update zone size
            zone_size = nvme_zone_size(self.params['bdev_name'])
            self._set_zone_size(zone_size)

    def tearDown(self):
        if self.is_fake_zns():
            self._tearDownMalloc()

    def _test(self):
        workload = self._run_workload()
        time.sleep(self.params['runtime'])
        workload_wait_to_finish(workload)

    def _run_workload(self):
        size = min(self._get_workload_size(), self._get_bdev_size() - self._get_offset())

        cmd = "%s zns_iocheck_workload_create -b '%s'" \
              " --offset=%s --size=%s --bs=%s --iodepth=%d --numjobs=%s --rw=%s --rwmixread=%s" \
              " --runtime=%s --number_ios=%s --io_limit=%s --loops=%d" \
              " --fake_zns=%s --zone_size=%s --zone_capacity=%s" \
              " --backfile='%s' --load_from_file=%s --load_from_drive=%s" \
              % (RPC_SCRIPT, self.params['bdev_name'],
                 humansize(self.params['offset']), humansize(size), humansize(self.params['bs']), self.params['iodepth'],
                 self.params['numjobs'], self.params['rw'], self.params['rwmixread'],
                 self.params['runtime'], self.params['number_ios'], humansize(self.params['io_limit']), self.params['loops'],
                 self.params['fake_zns'], humansize(self.params['zone_size']), humansize(self.params['zone_capacity']),
                 self.params['backfile'], self.params['load_from_file'], self.params['load_from_drive'])
        return run_cmd_assert(cmd)

    def _set_iodepth(self, iodepth):
        self.params['iodepth'] = iodepth

    def _set_numjobs(self, numjobs):
        self.params['numjobs'] = numjobs

    def _get_workload_size(self):
        return self.params['size']

    def _set_workload_size(self, workload_size):
        self.params['size'] = workload_size

    def _get_offset(self):
        return self.params['offset']

    def _set_offset(self, offset):
        self.params['offset'] = offset

    def _set_req_bs(self, req_bs):
        self.params['bs'] = req_bs

    def _set_rw(self, rw):
        self.params['rw'] = rw

    def _get_block_size(self):
        return self.params['block_size']

    def _get_zone_size(self):
        return self.params['zone_size']

    def _set_zone_size(self, zone_size):
        self.params['zone_size'] = zone_size

    def _get_zone_capacity(self):
        return self.params['zone_capacity']

    def _set_zone_capacity(self, zone_capacity):
        self.params['zone_capacity'] = zone_capacity

    def _get_runtime(self):
        return self.params['runtime']

    def _get_bdev_size(self):
        """
        in bytes
        """
        return self.params['bdev_size']

    def _set_bdev_size(self, bdev_size):
        self.params['bdev_size'] = bdev_size

    def _get_num_zones(self):
        return self._get_bdev_size() // self._get_zone_size()

class CustomTest(GenericTestBase):
    def test_custome(self):
        self._test()

class MallocTestBase(GenericTestBase):
    def default_setup(self, fake_zns=True):
        super().default_setup(fake_zns=fake_zns)

class MallocTestIodepth(MallocTestBase):
    def test_iodepth(self):
        iodepth_list = [1, 2, 4, 8, 32, 128]
        for iodepth in iodepth_list:
            self._set_iodepth(iodepth)
            self._test()

class ZNSTestIodepth(MallocTestIodepth):
    def default_setup(self):
        super().default_setup(fake_zns=False)

class MallocTestNumjobs(MallocTestBase):
    def test_numjobs(self):
        job_list = [1, 2, 4]
        for numjobs in job_list:
            self._set_numjobs(numjobs)
            size = self._get_zone_size() * numjobs
            self._set_workload_size(size)
            self._test()

    def test_too_many_jobs(self):
        numjobs = 4
        self._set_numjobs(numjobs)
        workload = self._run_workload()

        self.assertTrue(workload_exists(workload))
        self.assertTrue(task_exists(workload + "t0"))
        for i in range(1, numjobs):
            task = workload + "t" + str(i)
            self.assertFalse(task_exists(task))

        time.sleep(self._get_runtime())
        workload_wait_to_finish(workload)

class ZNSTestNumjobs(MallocTestNumjobs):
    def default_setup(self):
        super().default_setup(fake_zns=False)

class MallocTestOffset(MallocTestBase):
    def test_offset(self):
        num_zones = self._get_num_zones()
        last_zone = num_zones - 1
        offset_list = [0, 1, random.randint(0, last_zone) % num_zones, last_zone]
        for offset in offset_list:
            self._set_offset(offset * self._get_zone_size())
            self._test()

class ZNSTestOffset(MallocTestOffset):
    def default_setup(self):
        super().default_setup(fake_zns=False)

class MallocTestReqbs(MallocTestBase):
    def test_req_bs(self):
        self._set_workload_size(min(100, self._get_num_zones()) * self._get_zone_size())
        req_bz_list = ["4KB", "12KB", "64KB", "1MB"]
        for bs in req_bz_list:
            self._set_req_bs(naturalsize(bs))
            self._test()

class ZNSTestReqbs(MallocTestReqbs):
    def default_setup(self):
        super().default_setup(fake_zns=False)

class MallocTestZoneRange(MallocTestBase):
    def test_zone_range(self):
        num_zones = self._get_num_zones()
        zone_range_list = [1, 4, 16, 64]
        for sz in zone_range_list:
            for offset in [0, num_zones - sz, random.randint(0, num_zones - sz)]:
                self._set_offset(offset * self._get_zone_size())
                self._set_workload_size(sz * self._get_zone_size())
                self._test()

class ZNSTestZoneRange(MallocTestZoneRange):
    def default_setup(self):
        super().default_setup(fake_zns=False)

class MallocTestWriteReadOneZone(MallocTestBase):
    def __do_write_read_one_zone(self, offset):
        # seq write
        self._set_rw("write")
        self._set_offset(offset)
        self._test()

        # seq read
        self._set_rw("read")
        self._set_offset(offset)
        self._test()

    def test_write_read_zone_0(self):
        return self.__do_write_read_one_zone(0)

    def test_write_read_zone_last(self):
        offset = (self._get_num_zones() - 1) * self._get_zone_size()
        return self.__do_write_read_one_zone(offset)

    def test_write_read_zone_random(self):
        index = random.randint(0, self._get_num_zones() - 1)
        print("random zone index=%d" % index)
        offset = index * self._get_zone_size()
        return self.__do_write_read_one_zone(offset)

class ZNSTestWriteReadOneZone(MallocTestWriteReadOneZone):
    def default_setup(self):
        super().default_setup(fake_zns=False)

class MallocTestZoneCap(MallocTestBase):
    def test_zone_cap(self):
        self._set_zone_size(4 * MB)
        self._set_zone_capacity(3 * MB)
        self._set_workload_size(100 * self._get_zone_size())
        self._test()

if __name__ == "__main__":
    """
    --mode malloc, zns, all
    --type default(60s), quick(20s), long(10m)
    https://stackoverflow.com/questions/17259718/python-run-a-unittest-testcase-without-calling-unittest-main/17259773#17259773
    """
    p = argparse.ArgumentParser(add_help=False)
    p.add_argument('--bdev_name', help="Name of the zone device")
    p.add_argument('--offset', help='start offset in bytes', type=naturalsize)
    p.add_argument('--size', help='workload size in bytes', type=naturalsize)
    p.add_argument('--bs', help='request block size in bytes', type=naturalsize)
    p.add_argument('--iodepth', help='queue depth', type=int)
    p.add_argument('--rw', help='read/write type')
    p.add_argument('--rwmixread', help='mixed read/write: read percentage', type=int)
    p.add_argument('--runtime', help='runtime in seconds', type=int)
    p.add_argument('--number_ios', help='number of IOs to finish', type=int)
    p.add_argument('--io_limit', help='IO run amount before finishing', type=naturalsize)
    p.add_argument('--numjobs', help='number of jobs to run concurrently', type=int)
    p.add_argument('--loops', help='number of loops', type=int)
    p.add_argument('--max_open_zones', help='max open zones for workload', type=int)
    p.add_argument('--fake_zns', help='fake zns device', type=str2bool)
    p.add_argument('--zone_size', help='fake zns: zone size', type=naturalsize)
    p.add_argument('--zone_capacity', help='fake zns: zone capacity', type=naturalsize)
    p.add_argument('--bdev_size', help='Malloc bdev size in MB', type=naturalsize)
    p.add_argument('--block_size', help='drive block size in bytes', type=naturalsize)
    p.add_argument('--backfile', help='backup verify file')
    p.add_argument('--load_from_file', help='load verify buffer from file', type=str2bool)
    p.add_argument('--load_from_drive', help='load verify buffer from drive', type=str2bool)

    args, extra_args = p.parse_known_args()
    USER_CFG = vars(args)

    # Now set the sys.argv to the unittest_args (leaving sys.argv[0] alone)
    sys.argv[1:] = extra_args
    unittest.main()
```