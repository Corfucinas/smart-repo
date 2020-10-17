// SPDX-License-Identifier: MIT

pragma solidity =0.7.3;

contract SimpleStorageExampleEatTheBlocks {
    string public data;

    function set(string calldata _data) external {
        data = _data;
    }

    function get() external view returns (string memory) {
        return data;
    }
}
