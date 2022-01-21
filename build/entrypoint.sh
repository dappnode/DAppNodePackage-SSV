#!/bin/bash

yq e -i '.db.Path = strenv(DB_PATH)' ./config.yml
yq e -i '.eth2.Network = strenv(NETWORK)' ./config.yml
yq e -i '.eth2.BeaconNodeAddr = strenv(BEACON_NODE_ADDR)' ./config.yml
yq e -i '.eth1.ETH1Addr = strenv(ETH1ADDR)' ./config.yml
yq e -i '.eth1.RegistryContractAddr = strenv(REGISTRY_CONTRACT_ADDR)' ./config.yml
yq e -i '.OperatorPrivateKey = strenv(OPERATOR_PRIVATE_KEY)' ./config.yml
yq e -i '.global.LogLevel = strenv(LOG_LEVEL)' ./config.yaml

BUILD_PATH=/go/bin/ssvnode make start-node
