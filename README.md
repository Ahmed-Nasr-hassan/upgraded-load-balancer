# upgraded-load-balancer

## required setup

![Alt text](./required-setup.jpg?raw=true)

### description

Balancing load over different regions in AWS

## recommended approach

![Alt text](./recommended%20approach.png?raw=true)

### description

This script utilizes Python to monitor changes on an AWS EC2 instances. When a change is detected, a Bash script is triggered to create resources using Terraform. Another Python script is then run to retrieve the IP addresses of the EC2 instances and update an NGINX configuration file, which is used as a load balancer for these instances.
