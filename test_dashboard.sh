#!/bin/bash

# Generate CPU Load
echo "Generating CPU load for 60 seconds..."
stress --cpu 2 --timeout 60

# You may need to install stress
# sudo apt update && sudo apt install -y stress