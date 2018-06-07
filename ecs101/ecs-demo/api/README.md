## Build the image

```bash
docker build -t api .
```

## Run the container

```bash
docker run -d -p 8000:8000 api
```

Test the container:
```bash
curl localhost:8000/api
```

Output:
```
Hello world! This is Python + Flask web example. I'm 2nd web API endpoint.
```
