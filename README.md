CHIP Auto-Shutdown
============================

This script will check if power is supplied through the micro USB attached to the CHIP.

This needs to be run as root due to the shutdown command.

This script does not have a loop internal to it and should be set to a cron job (preferably root cron) at a 5 or 10 minute interval.

# Installation

  ```
  git clone https://github.com/noimjosh/chip_autoshutdown.git
  cd chip_autoshutdown
  sudo cp ./chip_autoshutdown.sh /usr/bin/
  ```

# Cron Job Setup

Edit the root crontab

  ```
  sudo crontab -e
  ```

For 5 Minute check, enter:

  ```
  */5 * * * * /usr/bin/chip_autoshutdown.sh
  ```

For 10 Minute check, enter:

  ```
  */10 * * * * /usr/bin/chip_autoshutdown.sh
  ```


Thanks to:
xtacocorex: https://github.com/xtacocorex/chip_batt_autoshutdown/
CapnBry: https://bbs.nextthing.co/t/updated-battery-sh-dumps-limits-input-statuses/2921
