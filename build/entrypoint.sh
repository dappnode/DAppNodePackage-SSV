#!/bin/bash

# Assign proper value to _DAPPNODE_GLOBAL_EXECUTION_CLIENT_PRATER.
case $_DAPPNODE_GLOBAL_EXECUTION_CLIENT_PRATER in
"goerli-geth.dnp.dappnode.eth")
    _EXECUTION_LAYER_WS="ws://goerli-geth.dappnode:8546"
    ;;
"goerli-nethermind.dnp.dappnode.eth")
    _EXECUTION_LAYER_WS="ws://goerli-nethermind.dappnode:8546"
    ;;
"goerli-besu.dnp.dappnode.eth")
    _EXECUTION_LAYER_WS="ws://goerli-besu.dappnode:8546"
    ;;
"goerli-erigon.dnp.dappnode.eth")
    _EXECUTION_LAYER_WS="ws://goerli-erigon.dappnode:8545"
    ;;
*)
    echo "Unknown value for _DAPPNODE_GLOBAL_EXECUTION_CLIENT_PRATER Please confirm that the value is correct"
    exit 1
    ;;
esac

export EXECUTION_LAYER_WS=$_EXECUTION_LAYER_WS

# Assign proper value to _DAPPNODE_GLOBAL_CONSENSUS_CLIENT_PRATER.
case "$_DAPPNODE_GLOBAL_CONSENSUS_CLIENT_PRATER" in
"prysm-prater.dnp.dappnode.eth")
  _BEACON_NODE_API="http://beacon-chain.prysm-prater.dappnode:3500"
  ;;
"teku-prater.dnp.dappnode.eth")
  _BEACON_NODE_API="http://beacon-chain.teku-prater.dappnode:3500"
  ;;
"lighthouse-prater.dnp.dappnode.eth")
  _BEACON_NODE_API="http://beacon-chain.lighthouse-prater.dappnode:3500"
  ;;
"nimbus-prater.dnp.dappnode.eth")
  _BEACON_NODE_API="http://beacon-validator.nimbus-prater.dappnode:4500"
  ;;
"lodestar-prater.dnp.dappnode.eth")
  _BEACON_NODE_API="http://beacon-chain.lodestar-prater.dappnode:3500"
  ;;
*)
  echo "_DAPPNODE_GLOBAL_CONSENSUS_CLIENT_PRATER env is not set propertly"
  exit 1
  ;;
esac

export BEACON_NODE_API=$_BEACON_NODE_API

yq e -i '.db.Path = strenv(DB_PATH)' ./config.yml
yq e -i '.eth2.Network = strenv(NETWORK)' ./config.yml
yq e -i '.eth2.BeaconNodeAddr = strenv(BEACON_NODE_API)' ./config.yml
yq e -i '.eth1.ETH1Addr = strenv(EXECUTION_LAYER_WS)' ./config.yml
yq e -i '.p2p.TCPPort = strenv(P2P_TCP_PORT)' ./config.yml
yq e -i '.p2p.UDPPort = strenv(P2P_UDP_PORT)' ./config.yml
yq e -i '.OperatorPrivateKey = strenv(OPERATOR_PRIVATE_KEY)' ./config.yml
yq e -i '.global.LogLevel = strenv(LOG_LEVEL)' ./config.yaml

BUILD_PATH=/go/bin/ssvnode make start-node
