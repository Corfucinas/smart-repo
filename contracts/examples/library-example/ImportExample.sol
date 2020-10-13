// SPDX-License-Identifier: MIT

pragma solidity =0.7.3;
// pragma experimental ABIEncoderV2;
// pragma experimental SMTChecker;

import './ExampleLib.sol';

contract Import {
    using ExampleLib for uint256;
    uint256 public value;

    function calculate(uint256 _value1, uint256 _value2) public {
        // value = Math.divide(_value1, _value2); this can be used if it's on the same contract
        value = _value1.divide(_value2);
    }
}
