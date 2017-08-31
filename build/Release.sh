#!/bin/sh
cd ${TOPDIR}
tar -cvjf robot-release-`date +%Y%m%d`-`date +%H%M%S`.tar.bz2 out

