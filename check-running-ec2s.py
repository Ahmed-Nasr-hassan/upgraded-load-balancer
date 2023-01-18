# run this code at the backgrond
from time import sleep
import boto3
import os

while True:
    # sleep(30)
    regions = ['us-east-1', 'us-east-2', 'us-west-1', 'us-west-2']

    vpcs_ids=[]
    for region in regions:
        ec2 = boto3.client('ec2', region_name=region)
        response = ec2.describe_vpcs(Filters=[{'Name': 'tag:name', 'Values': ['terraform-vpc']}])
        vpcs = response['Vpcs']
        for vpc in vpcs:
            vpcs_ids.append(vpc['VpcId'])

    count=0
    for region in regions:
        ec2 = boto3.client('ec2', region_name=region)
        response = ec2.describe_instances()
        instances = response['Reservations']
        for instance in instances:
            try:
                if instance['Instances'][0]['VpcId'] in vpcs_ids:
                    count += 1
            except KeyError:
                    pass
    print(count)
    if count < 4:
        print("Running terraform ...")
        os.system("./east/run_terraform.sh")
        os.system("./west/run_terraform.sh")
        os.system("python3 nasr-load-balancer.py")

