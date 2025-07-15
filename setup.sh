#!/bin/bash

# Install Netdata
bash <(curl -Ss https://registry.my-netdata.io/kickstart-static64.sh)

# Open port 19999 if using ufw
# sudo ufw allow 19999