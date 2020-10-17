const AdvancedStorage = artifacts.require('EatTheBlocksAdvancedStorage')

module.exports = function (deployer) {
  deployer.deploy(AdvancedStorage)
}
