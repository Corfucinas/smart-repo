// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.8.0;

// if the contract does not wants to be deployed, write 'abstract' before contract

contract HelloWorld {
  string public value; // public allows exposing the variable to functions
  // this way we can avoid writing a function (ie 'function get()')
  string public default_value = "default_value";
  string public constant constant_function = "cannot_be_changed";
  bool public a_bool = true;
  bool public b_bool = false;
  int public one_int = -1;
  uint public another_int = 1;
  uint8 public small_number = 8;
  uint256 public bigger_number = 256;

  enum State {Waiting, Ready, Active}
  State public state; // this is a getter, assigns the enum to state

  constructor() {
    value = "Hello World!";
    state = State.Waiting; // this is the default value of 'state'
  }

  // function get() public view returns (string memory) {
  //   return value;
  // }

  function activate() public {
    state = State.Active;
  }

  function is_active() public view returns (bool) {
    return state == State.Active;
  }

  function set(string memory _value) public {
    value = _value;
  }

}
