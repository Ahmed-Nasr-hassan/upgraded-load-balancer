#!/bin/bash
cd ~/nws/terraform-files/east/
pwd
sudo terraform init
sudo terraform apply -auto-approve
echo "your resources are ready"