ECS 200
===

## Troubleshooting

### Fargate unable pull image

#### Scenario

Hello,

I cannot run my Fargate task. It looks like my Fargate task cannot
pull the image from Docker hub, could you please help me to find the issue?

#### Deploy the Troubleshooting lab

Using AWS CLI:

```bash
aws cloudformation create-stack --stack-name fargate-unable-pull-image --template-body file://$PWD/fargate-unable-pull-image.yml --parameters file://$PWD/fargate-unable-pull-image-params.json --region <REGION> --capabilities CAPABILITY_NAMED_IAM

```

Output:

```bash
{
    "StackId": "arn:aws:cloudformation:<REGION>:<ACCOUNT_ID>:stack/fargate-unable-pull-image/XXXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"
}
```

After deployed the stack, try to raise the desired count of the ECS service to 1.

You will find the task will fail to run.

#### Clean up

```bash
aws cloudformation delete-stack --stack-name fargate-unable-pull-image --region <REGION>
```

### Fargate cannot run task concurrency

#### Scenario

Hello,

I cannot run my Fargate task when it try to scale out, it show
cannot run tasks concurrency error, could you please help me to find the issue?


#### Deploy the Troubleshooting lab

Using AWS CLI:

```bash
aws cloudformation create-stack --stack-name fargate-cannot-run-tasks-concurrency --template-body file://$PWD/fargate-cannot-run-tasks-concurrency.yml --parameters file://$PWD/fargate-cannot-run-tasks-concurrency-params.json --region <REGION> --capabilities CAPABILITY_NAMED_IAM
```

Output:

```bash
{
    "StackId": "arn:aws:cloudformation:<REGION>:<ACCOUNT_ID>:stack/fargate-cannot-run-tasks-concurrency/XXXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"
}
```

After deployed the stack, try to increase the desired count of task for one of ECS service.

You will see the error message and the task will fail to provision.

#### Clean up

```bash
aws cloudformation delete-stack --stack-name fargate-cannot-run-tasks-concurrency --region <REGION>
```
