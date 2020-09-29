// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.8.0;

contract HelloWorld {
    string value;

    constructor() {
        value = "Hello World!";
    }

    function get() public view returns(string memory) {
        return value;
    }

    function set(string memory _value) public  {
        value = _value;
    }

}
