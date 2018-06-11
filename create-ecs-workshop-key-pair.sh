#!/bin/bash

AWS_REGION_FILE=aws-regions.txt

createKeyPair() {
    ssh-keygen -t rsa -C "$ECS_WORKSHOP_KEY_PAIR" -f ~/.ssh/$ECS_WORKSHOP_KEY_PAIR
}

getAWSRegions() {
    aws ec2 describe-regions --query 'Regions[].{Name:RegionName}' --output text > $AWS_REGION_FILE
}

importKeyPair() {
    if [ ! -f $AWS_REGION_FILE ]; then
        echo "Region file not found!"
        exit
    fi

    REGIONS=$(cat $AWS_REGION_FILE)
    for region in $REGIONS
    do
        echo "Import key pair: $ECS_WORKSHOP_KEY_PAIR in $region ..."
        aws ec2 import-key-pair --key-name "$ECS_WORKSHOP_KEY_PAIR" --public-key-material file://~/.ssh/$ECS_WORKSHOP_KEY_PAIR.pub --region $region
    done
}

removeKeyPair() {
    if [ ! -f $AWS_REGION_FILE ]; then
        echo "Region file not found!"
        exit
    fi

    REGIONS=$(cat $AWS_REGION_FILE)
    for region in $REGIONS
    do
        echo "Delete key pair: $ECS_WORKSHOP_KEY_PAIR in $region ..."
        aws ec2 delete-key-pair --key-name "$ECS_WORKSHOP_KEY_PAIR" --region $region
    done
}

if [ "$ECS_WORKSHOP_KEY_PAIR" = "" ]
then
    echo '[ERROR] Please define the $ECS_WORKSHOP_KEY_PAIR environment variable before creating the key pair (export ECS_WORKSHOP_KEY_PAIR=key-pair-name)'
    exit
fi

if [ "$1" = "clean" ]
then
    getAWSRegions
    removeKeyPair
else
    createKeyPair
    getAWSRegions
    importKeyPair
fi
