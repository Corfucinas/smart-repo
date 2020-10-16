/**
 * Use this file to configure your truffle project. It's seeded with some
 * common settings for different networks and features like migrations,
 * compilation and testing. Uncomment the ones you need or modify
 * them to suit your project as necessary.
 *
 * More information about configuration can be found at:
 *
 * truffleframework.com/docs/advanced/configuration
 *
 * To deploy via Infura you'll need a wallet provider (like @truffle/hdwallet-provider)
 * to sign your transactions before they're sent to a remote public node. Infura API
 * keys are available for free at: infura.io/register
 *
 * You'll also need a mnemonic - the twelve word phrase the wallet uses to generate
 * public/private key pairs. If you're publishing your code to GitHub make sure you load this
 * phrase from a file you've .gitignored so it doesn't accidentally become public.
 *
 */

require('custom-env').env('LOCAL')

const HDWalletProvider = require('@truffle/hdwallet-provider')
const NonceTrackerSubprovider = require('web3-provider-engine/subproviders/nonce-tracker')

module.exports = {
  test_file_extension_regexp: /.*\.ts$/,
  /**
   * Networks define how you connect to your ethereum client and let you set the
   * defaults web3 uses to send transactions. If you don't specify one truffle
   * will spin up a development blockchain for you on port 9545 when you
   * run `develop` or `test`. You can ask a truffle command to use a specific
   * network from the command line, e.g
   *
   * $ truffle test --network <network-name>
   */
  networks: {
    // Useful for testing. The `development` name is special - truffle uses it by default
    // if it's defined here and no other network is specified at the command line.
    // You should run a client (like ganache-cli, geth or parity) in a separate terminal
    // tab if you use this network and you must also set the `host`, `port` and `network_id`
    // options below to some value.
    //
    development: {
      host: 'localhost',
      port: 7545,
      network_id: '*', // Match any network id
      gas: 5000000,
      skipDryRun: false
      // gasPrice: 20000000000 // 20 gwei (in wei) (default: 100 gwei)
      // from: <address>,        // Account to send txs from (default: accounts[0])
    }

    // ropsten: {
    //   provider: new HDWalletProvider(
    //     process.env.DEPLOYMENT_ACCOUNT_KEY,
    //     'https://ropsten.infura.io/v3/' + process.env.INFURA_API_KEY
    //   ),
    //   network_id: 3, // Ropsten's id
    //   gas: 5500000, // Ropsten has a lower block limit than mainnet
    //   confirmations: 2, // # of confs to wait between deployments. (default: 0)
    //   timeoutBlocks: 200, // # of blocks before a deployment times out  (minimum/default: 50)
    //   skipDryRun: true // Skip dry run before migrations? (default: false for public nets )
    // },

    // kovan: {
    //   provider: new HDWalletProvider(
    //     process.env.DEPLOYMENT_ACCOUNT_KEY,
    //     'https://kovan.infura.io/v3/' + process.env.INFURA_API_KEY
    //   ),
    //   network_id: 42,
    //   gas: 5000000,
    //   gasPrice: 5000000000, // 5 Gwei
    //   skipDryRun: true
    // },
    // mainnet: {
    //   provider: function () {
    //     var wallet = new HDWalletProvider(privatekey_mainnet, "https://mainnet.infura.io/v3/" + infura_v3_apikey);
    //     var nonceTracker = new NonceTrackerSubprovider();
    //     wallet.engine._providers.unshift(nonceTracker);
    //     nonceTracker.setEngine(wallet.engine);
    //     return wallet;
    //   },
    //   network_id: 1,
    //   gas: 5000000,
    //   gasPrice: 5000000000 // 5 Gwei
    // }
  },

  // this is necessary for coverage
  coverage: {
    host: 'localhost',
    network_id: '*',
    port: 7545,
    gas: 0xfffffffffff,
    gasPrice: 0x01
  },

  // Set default mocha options here, use special reporters etc.
  mocha: {
    timeout: 100000,
    reporter: 'eth-gas-reporter'
  },

  etherscan: {
    apiKey: process.env.ETHERSCAN_API
  },

  plugins: ['solidity-coverage', 'truffle-plugin-verify'],

  compilers: {
    solc: {
      version: '0.7.3',
      settings: {
        optimizer: {
          enabled: true, // Default: false
          runs: 200 // Default: 200
        }
      }
    }
  },

  ens: {
    enabled: true
  }

  // verify: {
  //   preamble: "DNASwap Version: 1.0.0"
  // }
}
