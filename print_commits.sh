#!/bin/sh
BASEDIR=$(dirname "$0")
awk '{print $1}' $BASEDIR/backports_noreverts.txt | grep -v -f $BASEDIR/SKIPPED
