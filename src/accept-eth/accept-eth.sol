// SPDX-License-Identifier: MIT

// Need to add a rec. function not just fallback()

pragma solidity >=0.7.0 <0.8.0;

contract AcceptEth {
  mapping(address => uint256) public balances;
  address payable wallet; // need to be declared

  constructor(address payable _wallet) {
    wallet = _wallet;
  }

  fallback() external payable {
    // If not marked payable,
    //   it will throw exception if contract receives plain ether without data.
    // external is for only calling outside
    buy_token();
  }

  function buy_token() public payable {
    // people can call the function and buy ETH, and payable
    // buy a token
    balances[msg.sender] += 1;
    //send eth to the wallet
    wallet.transfer(msg.value); // value gets the amount of ETH sent
  }
}
