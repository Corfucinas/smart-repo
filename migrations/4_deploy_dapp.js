const SimpleSmartContract = artifacts.require('SimpleSmartContract')
const HelloWorldWeb = artifacts.require('HelloWorldWeb')

module.exports = function (deployer) {
  deployer.deploy(SimpleSmartContract)
  deployer.deploy(HelloWorldWeb)
}
