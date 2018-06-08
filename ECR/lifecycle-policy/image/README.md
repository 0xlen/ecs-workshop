## Image generator

### AWS CLI

Creates an image repository:


```bash
aws ecr create-repository --repository-name <NAME> --region <REGION>
```

Login to the Amazon ECR:

```bash
$(aws ecr get-login --no-include-email)
```

### Generate image

```bash
./generator.sh
```
