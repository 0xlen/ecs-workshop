## Install Docker Compose

```bash
sudo ./install_compose.sh
```

## Run the example - nginx

### Launch the container

```bash
cd nginx/
docker-compose -d up
```
Now you can try to access `localhost:80`

```bash
$ curl localhost

<!DOCTYPE html>
<html>
<head>
    <title>Welcome to nginx!</title>
    ....
</head>
<body>
    <h1>Welcome to nginx!</h1>
    ...
</body>
</html>
```

### Check the container

```bash
docker-compose ps
```

### Clean up

```bash
docker-compose down
```
