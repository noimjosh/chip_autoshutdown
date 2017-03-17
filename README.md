CHIP Auto-Shutdown
============================

This script will check if power is supplied through the micro USB attached to the CHIP.

This needs to be run as root due to the shutdown command.

# Installation
If you already have git installed, skip this one (obviously).
  ```
  sudo apt-get install git
  ```
Clone this repository (or you could just download the files):
  ```
  git clone https://github.com/noimjosh/chip_autoshutdown.git
  ```
Install the script:
  ```
  cd chip_autoshutdown
  sudo cp ./chip_autoshutdown.sh /usr/bin/
  ```
Install systemd service (so it runs at boot):
  ```
  sudo cp ./chip_autoshutdown.service /lib/systemd/system/
  sudo systemctl daemon-reload
  sudo systemctl enable chip_autoshutdown.service
  ```
Start it:
  ```
  sudo systemctl start chip_autoshutdown.service
  ```
  
#Thanks to
xtacocorex: https://github.com/xtacocorex/chip_batt_autoshutdown/

CapnBry: https://bbs.nextthing.co/t/updated-battery-sh-dumps-limits-input-statuses/2921
