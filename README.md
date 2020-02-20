# lnd-docker

This is a Dockerfile which will generate you LND images with a specific version of LND.

Example:
```
docker build --build-arg LND_VERSION=v0.9.0-beta .
```

Example with tag:
```
docker build --build-arg LND_VERSION=v0.9.0-beta . -t lnd:v0.9.0-beta
```
