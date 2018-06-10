#!/bin/bash
#
# Deploy the ECS101 troubleshooting stacks
# Eason Cao <yangxinc@amazon.com>

KEY_PAIR=''
REGION=''

# Configuration
setup_KeyPairVar() {
    if [ "$ECS_WORKSHOP_KEY_PAIR" != "" ]
    then
        KEY_PAIR=$ECS_WORKSHOP_KEY_PAIR
    fi

    if [ "$KEY_PAIR" = "" ]
    then
        echo '[ERROR] No key pair'
        exit

    fi
}

setup_Region() {
    if [ "$ECS_WORKSHOP_REGION" != "" ]
    then
        REGION=$ECS_WORKSHOP_REGION
    fi

    if [ "$REGION" = "" ]
    then
        echo '[ERROR] No region information, please setup $ECS_WORKSHOP_REGION for deploying stack'
        exit

    fi
}

replace_KeyPairInParameter() {
    echo "Replacing parameters with key pair: $KEY_PAIR"
    sed -i "s/<KEY_PAIR_NAME>/$KEY_PAIR/" *-params.json
}

reset_ParameterFiles() {
    echo 'Reset the parameter files ...'
    git checkout *-params.json
}

# Troubleshooting stack: Unable to place ECS task
deploy_UnablePlaceTask() {
    echo "Deploy stack: unable-place-task in $REGION ..."
    aws cloudformation create-stack --stack-name unable-place-task --template-body file://$PWD/unable-place-task.yml --parameters file://$PWD/unable-place-task-params.json --region $REGION --capabilities CAPABILITY_NAMED_IAM
}


clean_UnablePlaceTask() {
    echo 'Clean up stack: unable-place-task ...'
    aws cloudformation delete-stack --stack-name unable-place-task --region $REGION
}

# Troubleshooting stack: Task restart issue
deploy_TaskRestartIssue() {
    echo "Deploy stack: task-restart-issue in $REGION ..."
    aws cloudformation create-stack --stack-name task-restart-issue --template-body file://$PWD/task-restart-issue.yml --parameters file://$PWD/task-restart-issue-params.json --region $REGION --capabilities CAPABILITY_NAMED_IAM
}

clean_TaskRestartIssue() {
    echo 'Clean up stack: task-restart-issue ...'
    aws cloudformation delete-stack --stack-name task-restart-issue --region $REGION
}

if [ "$1" = "reset" ]
then
    reset_ParameterFiles
elif [ "$1" = "clean" ]
then
    setup_Region

    echo 'Removing stacks ...'
    clean_UnablePlaceTask
    clean_TaskRestartIssue
else
    setup_Region
    setup_KeyPairVar
    replace_KeyPairInParameter

    echo 'Deploying stacks ...'
    deploy_UnablePlaceTask
    deploy_TaskRestartIssue
fi
