/* The Web3 library needs to know the ABI of the contract
This is a JSON object that holds all the external function of the contract
it also needs to know the address of the smart contract
*/

var contractABI = []
var contractAddress = '0x02ECD2348B40A0A86Df612b14521E59a22A046Dd' // deployed address in truffle
var web3 = new Web3('https://localhost:9080') // instance of the library Web3, port is the ganache chain
var simpleSmartContract = new web3.eth.Contract(contractABI, contractAddress)

console.log(simpleSmartContract)

web3.eth.getAccounts().then(console.log) // this returns a promise
