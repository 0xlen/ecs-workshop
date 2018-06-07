## Build the image

```bash
docker build -t web .
```
## Run the container

```bash
docker run -d -p 3000:3000 web
```

Test the container:
```bash
curl localhost:3000/web
```

Output:
```
Hi! This web page is using Python + Flask. I'm 1st web endpoint.
```
