# **SSV Holesky**

SSV is a network of validators that use a decentralized network of operators to run their validators. This package allows you to run an SSV Operator Node on Ethereum mainnet.

## Requirements

1. This package **requires a synced Mainnet Node**, configured in the [Mainnet Stakers UI](http://my.dappnode/stakers/mainnet) in order to function properly.

2. As soon as the Operator registration is done, make sure to **download the Backup** in the [Backup tab](http://my.dappnode/packages/my/ssv.dnp.dappnode.eth/backup) to avoid losing any critical files.

## Registration Steps

1. Install the package setting the setup mode to "New Operator".

2. Get the operator public key that will be shown in the [SSV Info Tab](http://my.dappnode/packages/my/ssv.dnp.dappnode.eth/info).

3. Register as an operator following the [SSV documentation](https://docs.ssv.network/operator-user-guides/operator-management/registration) with the public key obtained in step 2.

## DKG Setup Steps

1. If you want to run the dkg service, make sure the operator is registered in the SSV network and check the dkg service is not stopped in the [SSV Info Tab](http://my.dappnode/packages/my/ssv.dnp.dappnode.eth/info).

2. Add your node as a DKG endpoint in the [SSV App Operator Config](https://app.ssv.network/my-account/operator/edit-metadata). You must set: `http://<your-public-ip>:14516`.

## Troubleshoting

- If the `OPERATOR_ID` is not automatically fetched in dkg service from SSV API, you can manually set it in the [SSV Config Tab](http://my.dappnode/packages/my/ssv.dnp.dappnode.eth/config).

Full official documentation can be found [here](https://docs.ssv.network/learn/introduction).
