// SPDX-License-Identifier: MIT

pragma solidity =0.7.3;

contract EatTheBlocksAdvancedStorage {
    uint256[] private _ids;

    function add(uint256 id) external {
        _ids.push(id);
    }

    function get(uint256 i) external view returns (uint256) {
        return _ids[i];
    }

    function getAll() external view returns (uint256[] memory) {
        return _ids;
    }

    function length() external view returns (uint256) {
        return _ids.length;
    }
}
