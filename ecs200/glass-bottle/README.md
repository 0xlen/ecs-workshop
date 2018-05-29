Glass bottle project
===

If think about the container, you probably know about the bottle.

There is a glass bottle project, which is let you know how easily to break
your container.

## Let's break the glass bottle

Pull from docker hub

```bash
docker run --rm -m 128M --memory-swap 128M easoncao/glass-bottle
```

## Manually build the image


### Build the image

```bash
docker build -t glass .
```

### Break the glass bottle

```bash
docker run --rm -m 128M --memory-swap 128M glass
```
