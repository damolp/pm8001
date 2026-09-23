# SPDX-License-Identifier: GPL-2.0
#
# Kernel configuration file for the PM8001 SAS/SATA 8x6G based HBA driver
#
# Copyright (C) 2008-2009  USI Co., Ltd.


KVER ?= $(shell uname -r)
KDIR ?= /lib/modules/$(KVER)/build
PWD  := $(shell pwd)

FIRMWARE_DIR ?= /lib/firmware/pm8001
FIRMWARE     := istrimg.bin ilaimg.bin aap1img.bin iopimg.bin

.PHONY: all modules clean install install-firmware

all: modules

modules:
	$(MAKE) -C $(KDIR) M=$(PWD) modules

clean:
	$(MAKE) -C $(KDIR) M=$(PWD) clean

install:
	$(MAKE) -C $(KDIR) M=$(PWD) modules_install
	depmod -a $(KVER)

install-firmware:
	install -d -m 0755 $(DESTDIR)$(FIRMWARE_DIR)
	install -m 0644 $(addprefix firmware/,$(FIRMWARE)) $(DESTDIR)$(FIRMWARE_DIR)/
