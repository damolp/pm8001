# PM8001

This is a fork of Seagate's [pm8001](https://github.com/Seagate/pm8001) driver for kernel 2.6, but ported to 4.9.x (see branch 4.9.0-7-amd64) and ported to 6.12 (current HEAD).

4.9.x is just a direct update of the module to work with that kernel version (v0.1.36).

6.12 is flashless mode ported to mainline's driver (v0.1.40), with some interesting changes since 0.1.36 such as an increase of queues to 64 (cpu / MSI-X dependent) and the overall queue depth to 1024 from 256 ([ref](https://lore.kernel.org/all/20201005145011.23674-1-Viswas.G@microchip.com.com/)).

## How is this different to the Linux pm80xx driver?

The pm80xx driver in mainline assumes that the firmware is already on the HBA, in our case the HBA is in a "flashless" mode meaning that we need to provide the firmware to the HBA for it to actually do something.

This specific flashless PM8001 card is found in some Xyratex disk shelves, the one I have is an ex-StorSimple shelf (pre-Azure days). 

## Why?

With the cost of storage in 2026 going through the roof thanks to AI I needed some cheap storage, so a friend gave me some old 6TB 3.5" hard drives that he had decommissioned from his NAS.

I purchased the StorSimple shelf off of eBay back in 2017 for $50 with the idea of getting it to work on Linux but like most things that project got shelved due to constraints such as power / noise / time. But given the cost of hard drives in 2026 it now makes sense to resurrect this hardware and get it running.

Eventually I'll do a YouTube video on this.


## Usage

I've added dkms config so that it should be super simple to install (and automatically re-build on new kernel versions):
```
$ git clone https://github.com/damolp/pm8001.git
$ cd p8001
$ sudo dkms add .
$ sudo dkms build pm80xx/0.1.40
$ sudo dkms install pm80xx/0.1.40
$ sudo update-initramfs -u
```

Once installed you can differentiate between this module and mainline through the `flashless` parameter
```
$ sudo modinfo pm80xx | grep flashless
parm:           flashless:Flashless Firmware mode
```

Upon loading the module or booting the system you should see flashless mode taking effect in dmesg:
```
[   22.120073] pm80xx0:: pm8001_hda_detect 1013: HDA: boot ROM is waiting for firmware
[   22.127766] pm80xx0:: pm8001_chip_soft_rst 1511: using flashless (HDA) firmware boot
[   22.157396] pm80xx0:: pm8001_chip_hda_load_fw 893: flashless boot: loading firmware from host (istr 8680, ila 54108, aap1 187580, iop 347716 bytes)
[   22.170682] pm80xx0:: pm8001_chip_soft_rst_sig 1210: HDA: boot ROM idle, skipping FW ready check
[   22.179545] pm80xx0:: pm8001_chip_soft_rst_sig 1229: MBIC - NMI Enable VPE0 (IOP)= 0xffffffff
[   22.183498] pm80xx0:: pm8001_chip_soft_rst_sig 1240: MBIC - NMI Enable VPE0 (AAP1)= 0x3ef3f
[   22.183498] pm80xx0:: pm8001_chip_soft_rst_sig 1245: PCIE -Event Interrupt Enable = 0x40fcf
[   22.183498] pm80xx0:: pm8001_chip_soft_rst_sig 1250: PCIE - Event Interrupt  = 0x0
[   22.183498] pm80xx0:: pm8001_chip_soft_rst_sig 1255: PCIE -Error Interrupt Enable = 0xffffffff
[   22.183498] pm80xx0:: pm8001_chip_soft_rst_sig 1260: PCIE - Error Interrupt = 0x0
[   22.183498] pm80xx0:: pm8001_chip_soft_rst_sig 1280: GSM 0x0(0x00007b88)-GSM Configuration and Reset = 0x7b89
[   22.183498] pm80xx0:: pm8001_chip_soft_rst_sig 1297: GSM 0x0 (0x00007b88 ==> 0x00004088) - GSM Configuration and Reset is set to = 0x4089
[   22.183498] pm80xx0:: pm8001_chip_soft_rst_sig 1304: GSM 0x700038 - Read Address Parity Check Enable = 0xffffff
[   22.183498] pm80xx0:: pm8001_chip_soft_rst_sig 1308: GSM 0x700038 - Read Address Parity Check Enable is set to = 0x0
[   22.183498] pm80xx0:: pm8001_chip_soft_rst_sig 1314: GSM 0x700040 - Write Address Parity Check Enable = 0xffffff
[   22.183498] pm80xx0:: pm8001_chip_soft_rst_sig 1318: GSM 0x700040 - Write Address Parity Check Enable is set to = 0x0
[   22.183498] pm80xx0:: pm8001_chip_soft_rst_sig 1324: GSM 0x300048 - Write Data Parity Check Enable = 0xffffff
[   22.183498] pm80xx0:: pm8001_chip_soft_rst_sig 1327: GSM 0x300048 - Write Data Parity Check Enable is set to = 0x0
[   22.183498] pm80xx0:: pm8001_chip_soft_rst_sig 1341: GPIO Output Control Register: = 0x0
[   22.183498] pm80xx0:: pm8001_chip_soft_rst_sig 1356: Top Register before resetting IOP/AAP1:= 0x87fe01ff
[   22.183498] pm80xx0:: pm8001_chip_soft_rst_sig 1363: Top Register before resetting BDMA/OSSP: = 0x87fe01e7
[   22.183498] pm80xx0:: pm8001_chip_soft_rst_sig 1373: Top Register before bringing up BDMA/OSSP:= 0x87fc01e6
[   22.183498] pm80xx0:: pm8001_chip_soft_rst_sig 1390: GSM 0x0 (0x00007b88)-GSM Configuration and Reset = 0x4089
[   22.183498] pm80xx0:: pm8001_chip_soft_rst_sig 1404: GSM (0x00004088 ==> 0x00007b88) - GSM Configuration and Reset is set to = 0x7b89
[   22.183498] pm80xx0:: pm8001_chip_soft_rst_sig 1410: GSM 0x700038 - Read Address Parity Check Enable = 0x0
[   22.183498] pm80xx0:: pm8001_chip_soft_rst_sig 1414: GSM 0x700038 - Read Address Parity Check Enable is set to = 0xffffff
[   22.183498] pm80xx0:: pm8001_chip_soft_rst_sig 1419: GSM 0x700040 - Write Address Parity Check Enable is set to = 0xffffff
[   22.183498] pm80xx0:: pm8001_chip_soft_rst_sig 1425: GSM 0x700048 - Write Data Parity Check Enable is set to = 0xffffff
[   22.654244] pm80xx0:: pm8001_chip_soft_rst_sig 1448: SPC HDA soft reset Complete
[   22.662648] pm80xx0:: pm8001_chip_hda_load_fw 918: HDA Mode!
[   22.669284] pm80xx0:: pm8001_hda_gsm_copy 743: HDA: copy 8680 bytes to GSM 0x47e000
[   22.678237] pm80xx0:: pm8001_hda_gsm_copy 743: HDA: copy 54108 bytes to GSM 0x400000
[   22.718378] pm80xx0:: pm8001_hda_wait_exec_rsp 705: HDA: ILA accepted
[   22.738323] pm80xx0:: pm8001_hda_gsm_copy 743: HDA: copy 187580 bytes to GSM 0x426000
[   22.838200] pm80xx0:: pm8001_hda_gsm_copy 743: HDA: copy 347716 bytes to GSM 0x426000
```