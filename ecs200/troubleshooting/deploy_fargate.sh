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

# Troubleshooting stack: Fargate unable pull image
deploy_FargateUnablePullImage() {
    echo "Deploy stack: fargate-unable-pull-image in $REGION ..."
    aws cloudformation create-stack --stack-name fargate-unable-pull-image --template-body file://$PWD/fargate-unable-pull-image.yml --parameters file://$PWD/fargate-unable-pull-image-params.json --region $REGION --capabilities CAPABILITY_NAMED_IAM
}


clean_FargateUnablePullImage() {
    echo 'Clean up stack: fargate-unable-pull-image ...'
    aws cloudformation delete-stack --stack-name fargate-unable-pull-image --region $REGION
}

# Troubleshooting stack: Fargate cannot run task concurrency
deploy_FargateCannotRunTasksConcurrency() {
    echo "Deploy stack: fargate-cannot-run-tasks-concurrency in $REGION ..."
    aws cloudformation create-stack --stack-name fargate-cannot-run-tasks-concurrency --template-body file://$PWD/fargate-cannot-run-tasks-concurrency.yml --parameters file://$PWD/fargate-cannot-run-tasks-concurrency-params.json --region $REGION --capabilities CAPABILITY_NAMED_IAM
}

clean_FargateCannotRunTasksConcurrency() {
    echo 'Clean up stack: fargate-cannot-run-tasks-concurrency ...'
    aws cloudformation delete-stack --stack-name fargate-cannot-run-tasks-concurrency --region $REGION
}

# Troubleshooting stack: Same task definition but fail to run task
deploy_SameTDFailRunTask() {
    echo "Deploy stack: fail-to-access-container in $REGION ..."
    aws cloudformation create-stack --stack-name sameTD-fail-run-task --template-body file://$PWD/sameTD-fail-run-task.yml --parameters file://$PWD/sameTD-fail-run-task-params.json --region $REGION --capabilities CAPABILITY_NAMED_IAM
}

clean_SameTDFailRunTask() {
    echo 'Clean up stack: fail-to-access-container ...'
    aws cloudformation delete-stack --stack-name sameTD-fail-run-task --region $REGION
}

if [ "$1" = "reset" ]
then
    reset_ParameterFiles
elif [ "$1" = "clean" ]
then
    setup_Region

    echo 'Removing stacks ...'
    clean_FargateUnablePullImage
    clean_FargateCannotRunTasksConcurrency
    clean_SameTDFailRunTask
elif [ "$1" = "FargateCannotRunTasksConcurrency" ]
then
    setup_Region
    setup_KeyPairVar
    replace_KeyPairInParameter

    deploy_FargateCannotRunTasksConcurrency
else
    setup_Region
    setup_KeyPairVar
    replace_KeyPairInParameter

    echo 'Deploying stacks ...'
    deploy_FargateUnablePullImage
    deploy_SameTDFailRunTask
fi
