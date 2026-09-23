#!/bin/sh
# SPDX-License-Identifier: GPL-2.0
#
# DKMS POST_INSTALL hook: install the flashless (HDA) firmware images.
# DKMS runs this from the module source directory with an unspecified cwd,
# so resolve paths relative to the script itself.

set -e
cd "$(dirname "$0")"
exec make install-firmware
