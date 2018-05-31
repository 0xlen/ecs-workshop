

## Troubleshooting

### No instancce in the ECS Cluster

#### Scenario

Hello,

I tried to create a ECS cluster and launch a container instance.
But I cannot see my container instnace in the ECS cluster, could
you please help me to find the issue?

#### Deploy the Troubleshooting lab

Open `no-instance-in-cluster-params.json`, edit the `KeyPair`
parameter value(`ParameterValue`) as your key pair name.

Using AWS CLI:

```bash
aws cloudformation create-stack --stack-name no-instance-in-cluster --template-body file://$PWD/no-instance-in-cluster.yml --parameters file://$PWD/no-instance-in-cluster-params.json --region <REGION> --capabilities CAPABILITY_NAMED_IAM

```

Output:

```bash
{
    "StackId": "arn:aws:cloudformation:<REGION>:<ACCOUNT_ID>:stack/no-instance-in-cluster/XXXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"
}
```

#### Clean up

```bash
aws cloudformation delete-stack --stack-name no-instance-in-cluster --region <REGION>
```


### Wrong ECS Cluster

#### Scenario

Hello,

I created an ECS cluster and launch an EC2 instance.
But it looks like my EC2 instance register to 'default'
instead of the ECS cluster I just created.
Is there any problem in the ECS settings?

#### Deploy the Troubleshooting lab

Open `wrong-ecs-cluster-params.json`, edit the `KeyPair`
parameter value(`ParameterValue`) as your key pair name.

Using AWS CLI:


```bash
aws cloudformation create-stack --stack-name wrong-ecs-cluster --template-body file://$PWD/wrong-ecs-cluster.yml --parameters file://$PWD/wrong-ecs-cluster-params.json --region <REGION> --capabilities CAPABILITY_NAMED_IAM
```

Output:
```bash
{
    "StackId": "arn:aws:cloudformation:<REGION>:<ACCOUNT_ID>:stack/wrong-ecs-cluster/XXXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"
}
```

#### Clean up

```bash
aws cloudformation delete-stack --stack-name wrong-ecs-cluster --region <REGION>
```


### Fail to access container

#### Scenario

Hello,

I created an ECS cluster and launch the container instance.
My container can successfully pass ELB health check, however, it is unaccessible if visit ELB

- http://XXXXX.<REGION>.elb.amazonaws.com
- http://XXXXX.<REGION>.elb.amazonaws.com/api

I also tried to launch another EC2 instance in the VPC, and it can correctly response
the web page:

```
curl http://<container_instance_private_ip>:<container_host_port>
```

#### Deploy the Troubleshooting lab

Open `fail-to-access-container-params.json`, edit the `KeyPair`
parameter value(`ParameterValue`) as your key pair name.

Using AWS CLI:


```bash
aws cloudformation create-stack --stack-name fail-to-access-container --template-body file://$PWD/fail-to-access-container.yml --parameters file://$PWD/fail-to-access-container-params.json --region <REGION> --capabilities CAPABILITY_NAMED_IAM
```

Output:
```bash
{
    "StackId": "arn:aws:cloudformation:<REGION>:<ACCOUNT_ID>:stack/fail-to-access-container/XXXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"
}
```

#### Clean up

```bash
aws cloudformation delete-stack --stack-name fail-to-access-container --region <REGION>
```
