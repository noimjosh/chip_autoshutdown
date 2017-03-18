#!/bin/bash

# Forked https://github.com/xtacocorex/chip_batt_autoshutdown
# Modified to shutdown on microUSB unplug with code from
# https://bbs.nextthing.co/t/updated-battery-sh-dumps-limits-input-statuses/2921

# 2017-03-17 - noimjosh

# MIT LICENSE, SEE LICENSE FILE

# LOGGING HAT-TIP TO http://urbanautomaton.com/blog/2014/09/09/redirecting-bash-script-output-to-syslog/

# THIS NEEDS TO BE RUN AS ROOT - RUN AS SERVICE DURING STARTUP

# SIMPLE SCRIPT TO POWER DOWN THE CHIP WHEN MICRO USB POWER IS LOST
# NOTE, THIS WILL ONLY WORK IF A LIPO BATTERY IS ATTACHED

# CHANGE THESE TO CUSTOMIZE THE SCRIPT
# ************************************
# ** THESE VALUES MUST BE  INTEGERS **
ASD_POLLING_WAIT=10
ASD_CONSECUTIVE_POLLS=3
# ************************************

# set ADC enabled for all channels
ADC=$(i2cget -y -f 0 0x34 0x82)
# if couldn't perform get, then exit immediately
[ $? -ne 0 ] && exit $?

if [ "$ADC" != "0xff" ] ; then
    i2cset -y -f 0 0x34 0x82 0xff
    # Need to wait at least 1/25s for the ADC to take a reading
    sleep 1
fi

ASD_POLLS_TRUE=0

while true
do
    # GET MICRO USB POWER STATUS
    PLUGGED_IN=$(i2cget -y -f 0 0x34 0x5a)

    # SEE IF POWER EXISTS ON MICRO USB
    if [ $(($PLUGGED_IN)) -ne 0 ]; then
        # echo "CHIP IS STILL RECEIVING POWER FROM MICRO USB"
        ASD_POLLS_TRUE=0
    else
        # echo "CHIP IS UNPLUGGED"
        ASD_POLLS_TRUE=$((ASD_POLLS_TRUE + 1))
        if [$(($ASD_POLLS_TRUE)) -eq $(($ASD_CONSECUTIVE_POLLS))]; then
          # echo "CHIP IS NO LONGER RECEIVING POWER FROM MICRO USB, INITIATING SHUTDOWN"
          shutdown now
        fi
    fi
    sleep $ASD_POLLING_WAIT
done
