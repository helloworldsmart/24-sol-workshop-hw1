# XueDAO - CONNECT Hackathon: XueToken Workshop

XueDAO is excited to present the **CONNECT Hackathon**, featuring a comprehensive Solidity workshop designed to provide
participants with hands-on experience in blockchain technology and smart contract development. As part of this workshop,
we will guide you through the creation and deployment of an ERC-20 token, aptly named **XueToken**.

## Workshop Overview

Participants in the workshop will have the opportunity to design, develop, and test XueToken, an ERC-20 compliant token.
The project is structured into three main parts, each focusing on a critical aspect of token functionality. To ensure a
comprehensive understanding, participants must complete the following steps and pass the associated unit tests.

## Tasks and Unit Tests

### 1. Implement Basic Token Transfer

Develop the core functionality to enable token transfers between addresses.

**Unit Test Command:**

```bash
forge test --mt test_CheckTransferPoints -vvv
```

### 2. Implement Token Approval

Enable address owners to approve third parties to spend tokens on their behalf.

**Unit Test Command:**

```bash
forge test --mt test_CheckApprovePoints -vvv
```

### 3. Implement TransferFrom Functionality

Allow third parties to transfer tokens on behalf of the address owners, within the approved limits.

**Unit Test Command:**

```bash
forge test --mt test_CheckTransferFromPoints -vvv
```

## Smart Contract Location

The smart contract for XueToken is located in the following directory:

```bash
./src/XueToken.sol
```

Unit tests are available in:

```bash
./test/XueToken.t.sol
```

## Usage

This is a list of the most frequently needed commands.

### Build

Build the contracts:

```sh
$ forge build
```

### Clean

Delete the build artifacts and cache directories:

```sh
$ forge clean
```

### Compile

Compile the contracts:

```sh
$ forge build
```

### Coverage

Get a test coverage report:

```sh
$ forge coverage
```

### Deploy

Deploy to Anvil:

```sh
$ forge script script/Deploy.s.sol --broadcast --fork-url http://localhost:8545
```

For this script to work, you need to have a `MNEMONIC` environment variable set to a valid
[BIP39 mnemonic](https://iancoleman.io/bip39/).

For instructions on how to deploy to a testnet or mainnet, check out the
[Solidity Scripting](https://book.getfoundry.sh/tutorials/solidity-scripting.html) tutorial.

### Format

Format the contracts:

```sh
$ forge fmt
```

### Gas Usage

Get a gas report:

```sh
$ forge test --gas-report
```

### Lint

Lint the contracts:

```sh
$ pnpm run lint
```

### Test

Run the tests:

```sh
$ forge test
```

Generate test coverage and output result to the terminal:

```sh
$ pnpm run test:coverage
```

Generate test coverage with lcov report (you'll have to open the `./coverage/index.html` file in your browser, to do so
simply copy paste the path):

```sh
$ pnpm run test:coverage:report
```

## Related Efforts

- [abigger87/femplate](https://github.com/abigger87/femplate)
- [cleanunicorn/ethereum-smartcontract-template](https://github.com/cleanunicorn/ethereum-smartcontract-template)
- [foundry-rs/forge-template](https://github.com/foundry-rs/forge-template)
- [FrankieIsLost/forge-template](https://github.com/FrankieIsLost/forge-template)

## License

This project is licensed under MIT.
