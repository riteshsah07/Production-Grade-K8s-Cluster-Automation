#!/bin/bash
set -e

# Note: common.sh content will be prepended by Terraform

echo "Worker node setup complete (dependencies installed)."
echo "To join this node to the cluster:"
echo "1. SSH into the master node."
echo "2. Run 'cat /home/ubuntu/join.sh' to get the join command."
echo "3. SSH into this worker node and run the join command with sudo."
