module.exports = {
  networks: {
    development: {
      host: 'localhost',
      port: 7545,
      network_id: '*', // Match any network id
      gas: 5000000
      // gasPrice: 20000000000 // 20 gwei (in wei) (default: 100 gwei)
      // from: <address>,        // Account to send txs from (default: accounts[0])
    }
  },
  // ropsten: {
  //   provider: () => new HDWalletProvider(mnemonic, `https://ropsten.infura.io/v3/YOUR-PROJECT-ID`),
  //   network_id: 3,       // Ropsten's id
  //   gas: 5500000,        // Ropsten has a lower block limit than mainnet
  //   confirmations: 2,    // # of confs to wait between deployments. (default: 0)
  //   timeoutBlocks: 200,  // # of blocks before a deployment times out  (minimum/default: 50)
  //   skipDryRun: true     // Skip dry run before migrations? (default: false for public nets )
  //   },
  mocha: {
    timeout: 100000
  },
  compilers: {
    solc: {
      version: '0.7.0',
      settings: {
        optimizer: {
          enabled: true, // Default: false
          runs: 200 // Default: 200
        }
      }
    }
  }
}
