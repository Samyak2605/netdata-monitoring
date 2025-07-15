#!/bin/bash

echo "Stopping and removing Netdata..."
sudo pkill netdata
sudo rm -rf /opt/netdata