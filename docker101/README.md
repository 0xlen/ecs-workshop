## Build image

```bash
$ docker build -t docker101 .
```

## Run the container

Without port mapping

```bash
docker run -d docker101
```

Port mapping

```bash
docker run -d -p 8080:80 docker101
```
Enter the container space

```bash
docker exec -it de4cd /bin/bash
```
