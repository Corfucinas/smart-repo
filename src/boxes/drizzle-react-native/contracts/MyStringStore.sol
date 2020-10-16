// SPDX-License-Identifier: MIT

pragma solidity =0.7.3;

contract MyStringStore {
    string public myString = 'Hello World';

    function set(string memory x) public {
        myString = x;
    }
}
