ECS 101 - Schedule Task Hands-on
===

## Create a schedule task (cron)

### Step 1: Register the task definition

Use AWS CLI to register the task definition:

```bash
aws ecs register-task-definition --cli-input-json file://cron-job-task-def.json --region <REGION>
```

If the command executed successfully, cut the ARN of task definition in the output:

```
"taskDefinitionArn": "arn:aws:ecs:<REGION>:<ACCOUNT_ID>:task-definition/cron-job:<REVISION>"
```


### Step 2: Edit the configuration

Modify `create-cron-job.sh` with the following part:

```
REGION=<REGION>
CLUSTER_ARN=arn:aws:ecs:<REGION>:<ACCOUNT_ID>:cluster/<ECS_CLUSTER_NAME>
ROLE_ARN=arn:aws:iam::<ACCOUNT_ID>:role/ecsEventsRole
TASK_DEFINITION_ARN=<TASK_DEFINITION_ARN>
```

### Step 3: Create the schedule task

```bash
./create-cron-job.sh

```

If the schedule task is running, the schedule task will output the message to the mount point `/ecs-workshop` on the container instance.


## (Optional) Troubleshooting: Fail to invoke job Hands-on


### Step 1: Register the task definition


Use AWS CLI to register the task definition:

```bash
aws ecs register-task-definition --cli-input-json file://fail-invoke-job-task-def.json --region <REGION>
```

If the command executed successfully, cut the ARN of task definition in the output:

```
"taskDefinitionArn": "arn:aws:ecs:<REGION>:<ACCOUNT_ID>:task-definition/fail-invoke-cron:<REVISION>"
```

(Option a.) Run the task

Cut the subnet and the security group of the running container instance in your ECS cluster, and edit the network configuration file: `fail-invoke-network-config.json`.

Execute the command to test the task:

```bash
aws ecs run-task --cluster <ECS_CLUSTER_NAME> --task-definition fail-invoke-cron --network-configuration file://fail-invoke-network-config.json --region <REGION>
```
(Option b.) Quick run task:

```bash
aws ecs run-task --cluster awsvpc \
                 --task-definition fail-invoke-cron \
                 --region us-east-1 \
                 --network-configuration "awsvpcConfiguration={subnets=[subnet-XXXXXXXX],securityGroups=[sg-XXXXXXXX]}"
```

If the schedule task is running, the schedule task will output the message to the mount point `/ecs-workshop` on the container instance.

### Step 2: Edit the configuration

Modify `fail-invoke.sh` with the following part:

```
REGION=<REGION>
CLUSTER_ARN=arn:aws:ecs:<REGION>:<ACCOUNT_ID>:cluster/<ECS_CLUSTER_NAME>
ROLE_ARN=arn:aws:iam::<ACCOUNT_ID>:role/ecsEventsRole
TASK_DEFINITION_ARN=<TASK_DEFINITION_ARN>
```

### Step 3: Create the schedule task

```bash
./fail-invoke.sh

```

After created the schedule task, it will fail to invoke without any error message. Please find the issue in this troubleshooting scenario.

## (Optional) Troubleshooting: Unable to run cron job Hands-on

In this scenario, we will use the same task definition as we created on part `Create a schedule task (cron)`. If you remove the task definition before doing this, please back to the step and register the task definition.

```
"taskDefinitionArn": "arn:aws:ecs:<REGION>:<ACCOUNT_ID>:task-definition/cron-job:<REVISION>"
```


### Step 1: Edit the configuration

Modify `put-fail-job.sh` with the following part:

```
REGION=<REGION>
CLUSTER_ARN=arn:aws:ecs:<REGION>:<ACCOUNT_ID>:cluster/<ECS_CLUSTER_NAME>
ROLE_ARN=arn:aws:iam::<ACCOUNT_ID>:role/ecsEventsRole
TASK_DEFINITION_ARN=<TASK_DEFINITION_ARN>
```

### Step 2: Create the schedule task

```bash
./put-fail-job.sh

```

After created the schedule rule, the task will fail to run without any error message. Please find the issue in this troubleshooting scenario.
