import boto3
import os

upstream = "upstream backend {\n"
server_block = "server {\n    listen 80 default_server;\n    server_name _;\n    location / {\n        proxy_pass http://backend;\n    }\n}\n"

regions = ['us-east-1', 'us-east-2', 'us-west-1', 'us-west-2']

vpcs_ids = []
for region in regions:
    ec2 = boto3.client('ec2', region_name=region)
    response = ec2.describe_vpcs(Filters=[{'Name': 'tag:name', 'Values': ['terraform-vpc']}])
    vpcs = response['Vpcs']
    for vpc in vpcs:
        vpcs_ids.append(vpc['VpcId'])



for region in regions:
    ec2 = boto3.client('ec2', region_name=region)
    response = ec2.describe_instances()
    
    # Get all instances
    instances = response['Reservations']
    for instance in instances:
        try:
            if instance['Instances'][0]['VpcId'] in vpcs_ids:
                ip = instance['Instances'][0]['PublicIpAddress']
                upstream += f"    server {ip};\n"
        except KeyError:
            pass

upstream += "}\n"

with open("default", "w") as f:
    f.write(upstream)
    f.write(server_block)

os.system("sudo mv default /etc/nginx/sites-enabled/default")
os.system("sudo systemctl stop nginx")
os.system("sudo systemctl start nginx")
