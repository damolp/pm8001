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