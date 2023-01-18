#!/bin/bash
cd ~/nws/terraform-files/west/
sudo terraform init
sudo terraform apply -auto-approve
echo "your resources are ready"