# PM8001

This is a fork of Seagate's [pm8001](https://github.com/Seagate/pm8001) driver for kernel 2.6, but ported to 4.9.x (see branch 4.9.0-7-amd64) and ported to 6.12 (current HEAD).

4.9.x is just a direct update of the module to work with that kernel version.

## How is this different to the Linux pm80xx driver?

The pm80xx driver in mainline assumes that the firmware is already on the HBA, in our case the HBA is in a "flashless" mode meaning that we need to provide the firmware to the HBA for it to actually do something.

This specific flashless PM8001 card is found in some Xyratex disk shelves, the one I have is an ex-StorSimple shelf (pre-Azure days).

## Why?

With the cost of storage in 2026 going through the roof thanks to AI I needed some cheap storage, so a friend gave me some old 6TB 3.5" hard drives that he had decommissioned from his NAS.

I purchased the StorSimple shelf off of eBay back in 2017 for $50 with the idea of getting it to work on Linux but like most things that project got shelved due to constraints such as power / noise / time. But given the cost of hard drives in 2026 it now makes sense to resurrect this hardware and get it running.

Eventually I'll do a YouTube video on this.


## Usage

The firmware should be installed to `/lib/firmware/pm8001/`

```
$ shasum -a 256 /lib/firmware/pm8001/*
1760b15458ea7c21f1f9005225198462d6b45adbcb74a452b05c31e7e48a7bb7  /lib/firmware/pm8001/aap1img.bin
88876cb86555d43440fab3cf57c16ecd647edc0c488c0730dc3367c33ad0135a  /lib/firmware/pm8001/ilaimg.bin
177db92cec45b3d833e052c61eaa53d8bba21d963bab5e58779d865139573b4e  /lib/firmware/pm8001/iopimg.bin
5b625470c29d13b0720b533b3ab30376a78cd5c7766aea1f7789b2c4d0e2d5c7  /lib/firmware/pm8001/istrimg.bin
```

