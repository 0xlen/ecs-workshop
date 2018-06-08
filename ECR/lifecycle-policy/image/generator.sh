#!/bin/bash

PREFIX=prod
COUNT=20
ECR_REPO=<ACCOUNT_ID>.dkr.ecr.<REGION>.amazonaws.com/<REPO_NAME>

for (( index=1; index<=$COUNT; index++ ))
do
    i="$PREFIX-$index"
    echo Pushing image ... $i
    sed -i -E "s/(Hello) (\w|\-|\d)+/\1 $i/g" Dockerfile
    docker build -t $ECR_REPO:$i .
    docker push $ECR_REPO:$i
    docker rmi $ECR_REPO:$i
done
