FROM golang:1.15-alpine as builder

ARG LND_VERSION

# Force Go to use the cgo based DNS resolver. This is required to ensure DNS
# queries required to connect to linked containers succeed.
ENV GODEBUG netdns=cgo

# Install dependencies and install/build lnd.
RUN apk add --no-cache --update alpine-sdk \
    git \
    make \
    gcc \
&&  git clone https://github.com/lightningnetwork/lnd /go/src/github.com/lightningnetwork/lnd \
&&  cd /go/src/github.com/lightningnetwork/lnd \
&&  git checkout $LND_VERSION \
&&  make \
&&  make install tags="signrpc walletrpc chainrpc invoicesrpc routerrpc" \
&&  cd ~ \
&&  go get -d github.com/LN-Zap/lndconnect \
&&  cd /go/src/github.com/LN-Zap/lndconnect \
&&  make

# Start a new, final image to reduce size.
FROM alpine as final

# Copy the binaries and entrypoint from the builder image.
COPY --from=builder /go/bin/lncli /bin/
COPY --from=builder /go/bin/lnd /bin/
COPY --from=builder /go/bin/lndconnect /bin/

# Add bash.
RUN apk add --no-cache bash

# Copy the entrypoint script.
COPY "start-lnd.sh" .
RUN chmod +x start-lnd.sh
