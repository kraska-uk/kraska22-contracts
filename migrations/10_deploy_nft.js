const Kraska22 = artifacts.require('Kraska22');



module.exports = async (deployer, network) => {
  const name = 'KRASKA. Knitted Paintings, 2022';
  const symbol = 'KRASKA22';
  const contractURI = 'https://kraska-uk.github.io/nft-app/metadata/contract.json';
  const baseTokenURI = 'https://kraska-uk.github.io/nft-app/metadata/';

  let proxyRegistryAddress = '';
  if (network === 'rinkeby') {
    proxyRegistryAddress = '0xf57b2c51ded3a29e6891aba85459d600256cf317';
  } else {
    proxyRegistryAddress = '0xa5409ec958c83c3f309868babaca7c86dcb077c1';
  }

  const args = [name, symbol, contractURI, baseTokenURI, proxyRegistryAddress];
  await deployer.deploy(Kraska22, ...args);
};
