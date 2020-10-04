const ACCEPTETH = artifacts.require('AcceptEth')
const HELLOWORLD = artifacts.require('HelloWorld')
const IMPORTEXAMPLE = artifacts.require('Import')
const TOKEN = artifacts.require('MyToken')
const TODOLIST = artifacts.require('ToDoList')
const TOKENNAME = {
  name: 'Pedro Magic Coin',
  symbol: 'PMC'
}

module.exports = function (deployer) {
  // deployer.deploy(AcceptEth)
  deployer.deploy(HELLOWORLD)
  deployer.deploy(IMPORTEXAMPLE)
  deployer.deploy(TODOLIST)
  deployer.deploy(TOKEN, TOKENNAME.name, TOKENNAME.symbol)
}
