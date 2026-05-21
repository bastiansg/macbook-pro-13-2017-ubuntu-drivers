# Kernel 7 FaceTimeHD Build Fix

This documents the local changes made to build the `bcwc_pcie` FaceTimeHD
camera module on Ubuntu with kernel `7.0.0-15-generic`.

## Original failure

The camera module failed while compiling `bcwc_pcie/fthd_ddr.c`:

```text
error: storage size of 'state' isn't known
error: implicit declaration of function 'prandom_seed_state'
error: implicit declaration of function 'prandom_u32_state'
```

After fixing that, the next failure was in `bcwc_pcie/fthd_v4l2.c`:

```text
error: 'struct vb2_ops' has no member named 'wait_prepare'
error: 'struct vb2_ops' has no member named 'wait_finish'
```

## Changes made

### 1. Include the PRNG header directly

File: `bcwc_pcie/fthd_ddr.c`

Added:

```c
#include <linux/prandom.h>
```

Kernel 7 still provides `struct rnd_state`, `prandom_seed_state()`, and
`prandom_u32_state()`, but they are declared in `<linux/prandom.h>`. Older
kernels exposed them indirectly through other includes, so this driver built
without the explicit include before.

### 2. Guard removed videobuf2 callbacks

File: `bcwc_pcie/fthd_v4l2.c`

Changed the `vb2_ops` initializer so `wait_prepare` and `wait_finish` are only
used on older kernels:

```c
#if LINUX_VERSION_CODE < KERNEL_VERSION(6,17,0)
	.wait_prepare           = vb2_ops_wait_prepare,
	.wait_finish            = vb2_ops_wait_finish,
#endif
```

Newer kernels removed these callbacks from `struct vb2_ops`. The driver already
sets `q->lock`, so videobuf2 can handle the lock internally on newer kernels.

### 3. Make the installer fail fast

File: `install.sh`

Added:

```sh
set -e
```

This stops the installer at the first failing command. Previously, the script
continued into firmware, Bluetooth, and audio steps after the camera module
failed, which made the log harder to understand.

### 4. Make Bluetooth cleanup idempotent

File: `install.sh`

Changed:

```sh
rm -r build
```

to:

```sh
rm -rf build
```

This avoids failing when the Bluetooth `build` directory does not exist.

## Verification

The camera module was rebuilt with:

```sh
cd bcwc_pcie
make clean
make
```

Result:

```text
LD [M]  facetimehd.ko
```

The module now builds successfully on kernel `7.0.0-15-generic`.

## Notes

Only the camera module was built and verified. The full `sudo ./install.sh`
was not run, and `sudo make install` was not run.

The audio and Bluetooth parts are separate modules and may still need their own
kernel 7 compatibility fixes.
