

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
