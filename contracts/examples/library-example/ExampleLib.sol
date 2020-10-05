// SPDX-License-Identifier: MIT

pragma solidity = 0.7.2;
// pragma experimental ABIEncoderV2;
// pragma experimental SMTChecker;

library ExampleLib {
    // meant to be used inside a smart-contract
    function divide(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b > 0);
        uint256 c = a / b;
        return c;
    }

}
