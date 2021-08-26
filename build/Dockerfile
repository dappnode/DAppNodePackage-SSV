ARG UPSTREAM_VERSION

FROM bloxstaking/ssv-node:${UPSTREAM_VERSION}

RUN apk add yq --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community

ADD config.yml .
ADD entrypoint.sh /usr/local/bin

ENTRYPOINT [ "entrypoint.sh" ]