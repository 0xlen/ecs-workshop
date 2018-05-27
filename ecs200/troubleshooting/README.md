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

#### Clean up

```bash
aws cloudformation delete-stack --stack-name fargate-unable-pull-image --region <REGION>
```
