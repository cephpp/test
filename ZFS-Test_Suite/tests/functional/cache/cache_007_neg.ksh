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
# ident	"@(#)cache_007_neg.ksh	1.2	09/05/19 SMI"
#

. $STF_SUITE/tests/functional/cache/cache.kshlib
. $STF_SUITE/tests/functional/cache/cache.cfg
. $STF_SUITE/include/default_common_varible.kshlib
. $STF_SUITE/include/libtest.kshlib
. $STF_SUITE/commands.cfg

#################################################################################
#
# __stc_assertion_start
#
# ID: cache_007_neg
#
# DESCRIPTION:
#	A mirror/raidz/raidz2 cache is not supported. 
#
# STRATEGY:
#	1. Try to create pool with unsupported type
#	2. Verify failed to create pool.
#
# TESTABILITY: explicit
#
# TEST_AUTOMATION_LEVEL: automated
#
# CODING_STATUS: COMPLETED (2008-04-24)
#
# __stc_assertion_end
#
################################################################################
if [[ $# -ne 1 ]];then
	echo "Usage : One </dev> disk must"
	exit
fi
verify_runnable "global"
verify_disk_count "$LDEV2"

VDIR=`ls / | grep "disk" | tail -1`

log_assert "A mirror/raidz/raidz2 cache is not supported."
log_onexit cleanup

for type in "" "mirror" "raidz" "raidz2"
do
	for cachetype in "mirror" "raidz" "raidz1" "raidz2"
	do
		#log_mustnot $ZPOOL create $TESTPOOL $type $VDEV \
		#	cache $cachetype $LDEV $LDEV2
		log_mustnot $ZPOOL create $TESTPOOL $type /$VDIR/a /$VDIR/b  \
			cache $cachetype $1 /$VDIR/c
		#ldev=$(random_get $LDEV $LDEV2)
		#ldev=/$VDIR/a
		#log_mustnot verify_cache_device \
		#	$TESTPOOL $ldev $cachetype
		log_must datasetnonexists $TESTPOOL
		#zpool status $TESTPOOL
	done
done

log_pass "A mirror/raidz/raidz2 cache is not supported."
