// SPDX-License-Identifier: MIT

pragma solidity =0.7.3;

import '../SafeMathLib.sol';

library ERC20Lib {
    using SafeMathLib for uint256;

    struct TokenStorage {
        mapping(address => uint256) balances;
        mapping(address => mapping(address => uint256)) allowed;
        uint256 totalSupply;
    }

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );

    function init(TokenStorage storage self, uint256 _initial_supply) {
        self.totalSupply = _initial_supply;
        self.balances[msg.sender] = _initial_supply;
    }

    function transfer(
        TokenStorage storage self,
        address _to,
        uint256 _value
    ) returns (bool success) {
        self.balances[msg.sender] = self.balances[msg.sender].minus(_value);
        self.balances[_to] = self.balances[_to].plus(_value);
        Transfer(msg.sender, _to, _value);
        return true;
    }

    function transferFrom(
        TokenStorage storage self,
        address _from,
        address _to,
        uint256 _value
    ) returns (bool success) {
        var _allowance = self.allowed[_from][msg.sender];

        self.balances[_to] = self.balances[_to].plus(_value);
        self.balances[_from] = self.balances[_from].minus(_value);
        self.allowed[_from][msg.sender] = _allowance.minus(_value);
        Transfer(_from, _to, _value);
        return true;
    }

    function balanceOf(TokenStorage storage self, address _owner)
        constant
        returns (uint256 balance)
    {
        return self.balances[_owner];
    }

    function approve(
        TokenStorage storage self,
        address _spender,
        uint256 _value
    ) returns (bool success) {
        self.allowed[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(
        TokenStorage storage self,
        address _owner,
        address _spender
    ) constant returns (uint256 remaining) {
        return self.allowed[_owner][_spender];
    }
}
