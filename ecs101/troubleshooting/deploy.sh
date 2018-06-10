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

# Troubleshooting stack: No instancce in the ECS Cluster
deploy_NoInstanceInCluster() {
    echo 'Deploy stack: no-instance-in-cluster ...'
    aws cloudformation create-stack --stack-name no-instance-in-cluster --template-body file://$PWD/no-instance-in-cluster.yml --parameters file://$PWD/no-instance-in-cluster-params.json --region $REGION --capabilities CAPABILITY_NAMED_IAM
}


clean_NoInstanceInCluster() {
    echo 'Clean up stack: no-instance-in-cluster ...'
    aws cloudformation delete-stack --stack-name no-instance-in-cluster --region $REGION
}

# Troubleshooting stack: Wrong ECS Cluster
deploy_WrongECSCluster() {
    echo 'Deploy stack: wrong-ecs-cluster ...'
    aws cloudformation create-stack --stack-name wrong-ecs-cluster --template-body file://$PWD/wrong-ecs-cluster.yml --parameters file://$PWD/wrong-ecs-cluster-params.json --region $REGION --capabilities CAPABILITY_NAMED_IAM
}

clean_WrongECSCluster() {
    echo 'Clean up stack: wrong-ecs-cluster ...'
    aws cloudformation delete-stack --stack-name wrong-ecs-cluster --region $REGION
}

# Troubleshooting stack: Fail to access container
deploy_FailToAccessContainer() {
    echo 'Deploy stack: fail-to-access-container ...'
    aws cloudformation create-stack --stack-name fail-to-access-container --template-body file://$PWD/fail-to-access-container.yml --parameters file://$PWD/fail-to-access-container-params.json --region $REGION --capabilities CAPABILITY_NAMED_IAM
}

clean_FailToAccessContainer() {
    echo 'Clean up stack: fail-to-access-container ...'
    aws cloudformation delete-stack --stack-name fail-to-access-container --region $REGION
}

if [ "$1" = "reset" ]
then
    reset_ParameterFiles
elif [ "$1" = "clean" ]
then
    setup_Region

    echo 'Removing stacks ...'
    clean_NoInstanceInCluster
    clean_WrongECSCluster
    clean_FailToAccessContainer
else
    setup_Region
    setup_KeyPairVar
    replace_KeyPairInParameter

    echo 'Deploying stacks ...'
    deploy_NoInstanceInCluster
    deploy_WrongECSCluster
    deploy_FailToAccessContainer
fi
