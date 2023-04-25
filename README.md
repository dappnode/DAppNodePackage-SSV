# Dappnode Package SSV Göerli Testnet "Jato" V3

This package allows Dappnode Users to help test the SSV Network.  A pioneer in the field of DVT (Decentralized Validator Technology), SSV is a network of validators that use a decentralized network of operators to run their validators.  This package allows you to run an SSV Operator Node on the SSV Testnet "Jato" V3.

Note - You will need SSH or direct console access to your Dappnode in order to use it to generate your operator keys.

_Warning: This package is separate from the Original SSV Prater Package.
If you participated in the first V1 SSV testnet "Primus" please be sure to create a new operator account for this iteration of the SSV Testnet._

_Warning: This package has been modified for the Jato V3 Testnet, which will be restarted in Mid-February 2023. SSV Shifu Operators must upgrade to this version of the package or higher in order to continue operating on the network._

## Generate Operator Keys

**DO NOT** Reuse keys from the V1 "Primus" Testnet or V2 "Shifu"; You need to create new keys and register them [here](https://app.ssv.network/join/operator/register) .

You'll need a keypair in order to run an operator on SSV. To generate a new keypair, you will need access to a terminal on a machine connected to the Internet with Docker installed, such as your Dappnode.  You need to run the following command :
      
      docker run -d --name=ssv_node_op_key -it 'bloxstaking/ssv-node:latest' \
      /go/bin/ssvnode generate-operator-keys && docker logs ssv_node_op_key --follow \
      && docker stop ssv_node_op_key && docker rm ssv_node_op_key
      
This command will generate a PK (Public Key) and a SK (Secret Key). Make sure to back up the output of this command in a safe place and only enter the SK (Secret Key) in this field.  The SK (Secret Key) is all the characters (including special characters i.e. =) between the quotation marks (" ") directly following "{"app": "SSV-Node", "sk":"  in the output of the command.
      
## Operator Registration

Registration is free and open to anyone who wishes to operate validators with SSV. This is done in the Web App linked below.

Register your new operator (**DO NOT REUSE OPERATORS FROM THE V1 "Primus" TESTNET**) using this [Web App](https://app.ssv.network/join/operator/register)

Follow [these instructions](https://docs.ssv.network/run-a-node/operator-node/registration) to register your operator.
After registration, your operator becomes discoverable as one of the network's operators and SSV stakers can choose you as one of their validator's operators.

Full official documentation can be found [here](https://docs.ssv.network/learn/introduction).

Please check the official documentation from the SSV Team [here](https://docs.ssv.network/run-a-node/operator-node/installation#generate-operator-keys) for more information.
