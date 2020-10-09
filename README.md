# lnd-docker

This is a Dockerfile which will generate you LND images with a specific version of LND.

Example:
```
docker build --build-arg LND_VERSION=v0.11.1-beta .
```

Example with tag:
```
docker build --build-arg LND_VERSION=v0.11.1-beta . -t lnd:v0.11.1-beta
```
