ECS Workshop
===

## Pre-work: Before getting start

### Launch an EC2 instance and attach proper IAM role

- Follow the document: [Launch an Amazon EC2 Instance](https://docs.aws.amazon.com/quickstarts/latest/vmlaunch/step-1-launch-instance.html) to launch the EC2 instance.
- Follow the document to create an IAM role with the proper permission and [attach an IAM Role to an EC2 Instance](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/iam-roles-for-amazon-ec2.html#attach-iam-role). In this workshop, the deployment scripts will deploy troubleshooting environment by creating CloudFormation stacks, you can attach AWS managed policy `arn:aws:iam::aws:policy/AdministratorAccess` to the IAM role. (This IAM role is used to in this workshop, not recommend use the IAM role in practical or production environment.)
- Follow the [document](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/authorizing-access-to-an-instance.html#add-rule-authorize-access) to set up the proper security group for the EC2 instance to allow you can SSH into it.
- Install the Git and pull the workshop materials:

```bash
sudo yum install -y git
git clone https://github.com/0xlen/ecs-workshop
```

### Generate and import the SSH key pair for the workshop

NOTE: If you already have a general SSH key pair in all AWS region, you can skip this step.

Login to the EC2 instance and set up the key pair name by define `ECS_WORKSHOP_KEY_PAIR` variable:

```bash
export ECS_WORKSHOP_KEY_PAIR=ecs-workshop
```

Create and import the key pair to all AWS region:

```bash
$ ./create-ecs-workshop-key-pair.sh

Generating public/private rsa key pair.
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /home/ec2-user/.ssh/ecs-workshop.
Your public key has been saved in /home/ec2-user/.ssh/ecs-workshop.pub
...
Import key pair: ecs-workshop in ap-south-1 ...
{
    "KeyName": "ecs-workshop",
    "KeyFingerprint": "XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX"
}
...
Import key pair: ecs-workshop in us-west-2 ...
{
    "KeyName": "ecs-workshop",
    "KeyFingerprint": "XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX"
}
```

## Deploy the troubleshooting environment

### ECS 101

#### Deploy

Login to the EC2 instance and select an AWS region for deploying the environment by setting `ECS_WORKSHOP_REGION`. To prevent hit the number of default VPC limit, please select the region to have sufficient capacity can create 3 VPC.

Example:
```
export ECS_WORKSHOP_REGION=ap-southeast-1
```

Deploy the troubleshooting environment:

```bash
[ec2-user@host ecs-workshop]$ cd ecs101/troubleshooting/
[ec2-user@host ecs-workshop]$ ./deploy.sh
```

#### Clean up
```bash
[ec2-user@host ecs-workshop]$ ./deploy.sh reset
[ec2-user@host ecs-workshop]$ ./deploy.sh clean
```
