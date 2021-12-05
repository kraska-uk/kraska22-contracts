const dotenv = require('dotenv').config();
const HDWalletProvider = require('@truffle/hdwallet-provider');



module.exports = {
  compilers: {
    solc: {
      version: '0.8.10',
      settings: {
        optimizer: {
          enabled: true,
          runs: 999999,
        },
      }
    }
  },

  networks: {
    mainnet: {
      provider: () => new HDWalletProvider(
        process.env.MNEMONIC, `https://mainnet.infura.io/v3/${process.env.API_INFURA}`
      ),
      network_id: 1,
      gas: 5500000,
      //gasPrice: 15000000000,
      confirmations: 2,
      timeoutBlocks: 200,
      skipDryRun: false,
      production: true,
    },

    rinkeby: {
      provider: () => new HDWalletProvider(
        process.env.MNEMONIC, `https://rinkeby.infura.io/v3/${process.env.API_INFURA}`
      ),
      network_id: 4,
      gas: 5000000,
      confirmations: 2,
      timeoutBlocks: 200,
      skipDryRun: true,
      production: false,
    },
  },

  plugins: [
    'truffle-plugin-verify'
  ],

  api_keys: {
    etherscan: process.env.API_ETHERSCAN,
  },
};
