# **SSV**

The SSV Network is a decentralized, open-source Ethereum staking network that enhances validator key security and network redundancy using Distributed Validator Technology (DVT). This package allows you to run an SSV Operator Node on the Ethereum mainnet.

## Requirements

1. This package **requires a synced Mainnet Node**, configured in the [Mainnet Stakers UI](http://my.dappnode/stakers/mainnet) in order to function properly.

2. Ensure to **download the Backup** from the [Backup tab](http://my.dappnode/packages/my/ssv.dnp.dappnode.eth/backup) immediately after completing Operator registration to secure all critical files.

## Registration Steps

1. Begin the installation of the package by selecting "New Operator" as the setup mode.

2. Obtain the operator public key, which is displayed in the [SSV Info Tab](http://my.dappnode/packages/my/ssv.dnp.dappnode.eth/info).

3. Complete the registration as an operator by following the guidelines provided in the [SSV documentation](https://docs.ssv.network/operator-user-guides/operator-management/registration), using the public key from the previous step.

## DKG Setup Steps

1. Verify that your operator registration on the SSV network is active, and confirm that the DKG service is running by checking the [SSV Info Tab](http://my.dappnode/packages/my/ssv.dnp.dappnode.eth/info).

2. Configure your node as a DKG endpoint by adding `https://<your-public-ip>:14516` in the [SSV App Operator Config](https://app.ssv.network/my-account/operator/edit-metadata).

## Troubleshooting

- If the `OPERATOR_ID` is not retrieved automatically by the DKG service from the SSV API, you can manually enter it in the [SSV Config Tab](http://my.dappnode/packages/my/ssv.dnp.dappnode.eth/config).

For comprehensive information and additional resources, refer to the full official documentation [here](https://docs.ssv.network/learn/introduction).
