#!/bin/bash

SCRIPT_PATH=$PWD/run_background.sh
read -p "Add '@reboot  $SCRIPT_PATH' to the bottom of the crontab"
crontab -e

