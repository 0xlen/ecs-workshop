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

### Unable to place ECS task

#### Scenario

Hello,

I cannot scale out my ECS task, it shows “unable to place a task
because no container instance met all of its requirements”, why?


#### Deploy the Troubleshooting lab

Open `unable-place-task-params.json`, edit the `KeyPair`
parameter value(`ParameterValue`) as your key pair name.

Using AWS CLI:

```bash
aws cloudformation create-stack --stack-name unable-place-task --template-body file://$PWD/unable-place-task.yml --parameters file://$PWD/unable-place-task-params.json --region <REGION> --capabilities CAPABILITY_NAMED_IAM
```

Output:

```bash
{
    "StackId": "arn:aws:cloudformation:<REGION>:<ACCOUNT_ID>:stack/unable-place-task/XXXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"
}
```

After deployed the stack, try to increase the desired count of task for each of ECS services.

You will see the error message - `unable to place a task because no container instance met all of its requirements`.

#### Clean up

```bash
aws cloudformation delete-stack --stack-name unable-place-task --region <REGION>
```

### Same task definition but fail to run task

#### Scenario

Hello,

I created a task definition and it can successfully run the task in my
ECS services. However, if I tried to increase the number of task in one of
my ECS service, it will fail. Could you please help me to find the issue?


#### Deploy the Troubleshooting lab

Open `sameTD-fail-run-task-params.json`, edit the `KeyPair`
parameter value(`ParameterValue`) as your key pair name.

Using AWS CLI:

```bash
aws cloudformation create-stack --stack-name sameTD-fail-run-task --template-body file://$PWD/sameTD-fail-run-task.yml --parameters file://$PWD/sameTD-fail-run-task-params.json --region <REGION> --capabilities CAPABILITY_NAMED_IAM
```

Output:

```bash
{
    "StackId": "arn:aws:cloudformation:<REGION>:<ACCOUNT_ID>:stack/sameTD-fail-run-task/XXXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"
}
```

After deployed the stack, try to increase the desired count of task for each of ECS services.

You will see the error message in of the ECS service and the task will fail to run.

#### Clean up

```bash
aws cloudformation delete-stack --stack-name sameTD-fail-run-task --region <REGION>
```


### Task restart issue

#### Scenario

Hello,

I noticed that my task will restart after run a while,
the task will stop and restart again in ECS service.
Could you please help to find issue?

#### Deploy the Troubleshooting lab

Open `task-restart-issue-params.json`, edit the `KeyPair`
parameter value(`ParameterValue`) as your key pair name.

Using AWS CLI:

```bash
aws cloudformation create-stack --stack-name task-restart-issue --template-body file://$PWD/task-restart-issue.yml --parameters file://$PWD/task-restart-issue-params.json --region <REGION> --capabilities CAPABILITY_NAMED_IAM
```

Output:

```bash
{
    "StackId": "arn:aws:cloudformation:<REGION>:<ACCOUNT_ID>:stack/task-restart-issue/XXXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"
}
```

After deployed the stack, you will see the task will run for a while but quickly stop,
and restart again.


#### Clean up

```bash
aws cloudformation delete-stack --stack-name task-restart-issue --region <REGION>
```
