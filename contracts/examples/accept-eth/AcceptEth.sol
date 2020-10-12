// SPDX-License-Identifier: MIT

// Need to add a rec. function not just fallback()

pragma solidity =0.7.3;
// pragma experimental ABIEncoderV2;
// pragma experimental SMTChecker;

contract ERC20Token {
    // in order to talk to this smart contract we need to know the address
    string public name;
    mapping(address => uint256) public balances;

    function mint() external {
        // balances[msg.sender] ++; // internal calling, msg.sender is the address of the contract,
        //not who sent the transaction
        balances[msg.sender]++; // sender of the transaction, use this and not tx.origin
    }
}

contract AcceptEth {
    address payable internal wallet; // need to be declared
    address public token;
    // event Purchase(
    //   address _buyer,
    //   uint256 _amount
    // );

    constructor(address payable _wallet, address _token) {
        wallet = _wallet;
        token = _token;
    }

    receive() external payable {
      // If not marked payable,
      //   it will throw exception if contract receives plain ether without data.
      // external is for only calling outside
      buyToken();
    }

    function buyToken() public payable {
      // people can call the function and buy ETH, and payable
      //send eth to the wallet
      // ERC20Token _token = ERC20Token(address(token));  // pass address to know where it is deployed
      // _token.mint();
      ERC20Token(address(token)).mint();  // shorthand to not safe a variable
      wallet.transfer(msg.value); // value gets the amount of ETH sent
      // emit Purchase(msg.sender, 1);  // trigger event this will output to log
       //all of the event streams
      	// [ { "from": "0xd9145cce52d386f254917e481eb44e9943f39138", "topic": "0x2499a5330ab0979cc612135e7883ebc3cd5c9f7a8508f042540c34723348f632", "event": "Purchase", "args": { "0": "0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2", "1": "1", "_buyer": "0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2", "_amount": "1", "length": 2 } } ]
    }

}
