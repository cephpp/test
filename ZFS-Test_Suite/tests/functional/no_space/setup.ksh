#!/bin/ksh -p
#
# CDDL HEADER START
#
# The contents of this file are subject to the terms of the
# Common Development and Distribution License (the "License").
# You may not use this file except in compliance with the License.
#
# You can obtain a copy of the license at usr/src/OPENSOLARIS.LICENSE
# or http://www.opensolaris.org/os/licensing.
# See the License for the specific language governing permissions
# and limitations under the License.
#
# When distributing Covered Code, include this CDDL HEADER in each
# file and include the License file at usr/src/OPENSOLARIS.LICENSE.
# If applicable, add the following below this CDDL HEADER, with the
# fields enclosed by brackets "[]" replaced with your own identifying
# information: Portions Copyright [yyyy] [name of copyright owner]
#
# CDDL HEADER END
#

#
# Copyright 2009 Sun Microsystems, Inc.  All rights reserved.
# Use is subject to license terms.
#
# ident	"@(#)setup.ksh	1.4	09/01/12 SMI"
#

. $STF_SUITE/commands.cfg
. $STF_SUITE/include/libtest.kshlib
. $STF_SUITE/include/default_common_varible.kshlib
. $STF_SUITE/STF/usr/src/tools/stf/contrib/include/logapi.kshlib
. $STF_SUITE/tests/functional/no_space/enospc.cfg


if [ $(id -u) != 0 ]; then
    echo "You must run as root"
    exit 1;
fi

if [ $# != 1 ]; then
   echo "Usage : ./grow_pool_001_pos.ksh <diskname1>"
   exit 1;
fi

verify_runnable "global"


#if ! $(is_physical_device $DISKS) ; then
#	log_unsupported "This directory cannot be run on raw files."
#fi

#DISK=${DISKS%% *}

DISK=$1

#log_must set_partition 0 "" $SIZE $DISK

default_setup $DISK
