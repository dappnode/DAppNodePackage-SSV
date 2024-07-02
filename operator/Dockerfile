ARG OPERATOR_UPSTREAM_VERSION

FROM bloxstaking/ssv-node:${OPERATOR_UPSTREAM_VERSION}

# Use apt (Debian) --> SSV operator v1.3.6+
# RUN apt-get update && \
#     apt-get install -y curl jq ruby openssl && \
#     apt-get clean && \
#     rm -rf /var/lib/apt/lists/* && \
#     mkdir -p /data/operator/config

# Use apk (Alpine)
RUN apk update && \
    apk add --no-cache curl jq ruby openssl && \
    mkdir -p /data/operator/config

COPY node-config.yml /ssv-node/config/raw-node-config.yml
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENV P2P_TCP_PORT=12515 \ 
    P2P_UDP_PORT=13515 \
    OPERATOR_DATA_DIR=/data/operator \
    NODE_CONFIG_DIR=/ssv-node/config \
    NETWORK=mainnet \
    METRICS_PORT=15000 

ENTRYPOINT [ "entrypoint.sh" ]