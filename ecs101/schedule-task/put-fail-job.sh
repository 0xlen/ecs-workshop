#!/bin/bash
#
# Eason Cao <yangxinc@amazon.com>

# Edit the following part
REGION=<REGION>
CLUSTER_ARN=arn:aws:ecs:<REGION>:<ACCOUNT_ID>:cluster/<ECS_CLUSTER_NAME>
ROLE_ARN=arn:aws:iam::<ACCOUNT_ID>:role/ecsEventsRole
TASK_DEFINITION_ARN=<TASK_DEFINITION_ARN>

TARGET_ID=1
RULE_NAME=failScheduleECSTask
CONTAINER_NAME=cron-job-1

aws events put-rule --schedule-expression "cron(0/1 * * * ? *)" --name $RULE_NAME --region $REGION

aws events put-targets \
            --region $REGION \
            --rule $RULE_NAME \
            --targets "[{ \
                \"Id\": \"$TARGET_ID\", \
                \"Arn\": \"$CLUSTER_ARN\", \
                \"RoleArn\": \"$ROLE_ARN\", \
                \"EcsParameters\": { \"TaskDefinitionArn\": \"$TASK_DEFINITION_ARN\", \"TaskCount\": 1 }, \
                \"Input\": \"{ \\\"containerOverrides\\\": [{ \\\"name\\\": \\\"$CONTAINER_NAME\\\", \\\"environment\\\": [{ \\\"name\\\":\\\"aa\\\",\\\"value\\\":\\\"bb\\\"}] }] }\" \
            }]"
