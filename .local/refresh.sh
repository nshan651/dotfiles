#!/bin/bash

xrandr --output eDP1 --auto --primary --mode 1920x1080 --rotate normal --output DP1 --auto --mode 1920x1080 --rotate normal --right-of eDP1 --output DP2-3 --auto --mode 1920x1080 --rotate normal --right-of DP1

# Reload
/bin/sh ~/.config/polybar/launch.sh --blocks
