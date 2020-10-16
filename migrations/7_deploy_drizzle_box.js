const DrizzleBoxSimpleStorage = artifacts.require('DrizzleBoxSimpleStorage')
const DrizzleBoxComplexStorage = artifacts.require('DrizzleBoxComplexStorage')

module.exports = function (deployer) {
  deployer.deploy(DrizzleBoxSimpleStorage)
  deployer.deploy(DrizzleBoxComplexStorage)
}
