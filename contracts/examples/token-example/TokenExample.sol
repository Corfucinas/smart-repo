// SPDX-License-Identifier: MIT

// Need to add a rec. function not just fallback()

pragma solidity =0.7.3;
// pragma experimental ABIEncoderV2;
// pragma experimental SMTChecker;

contract ERC20TokenExample {
    // in order to talk to this smart contract we need to know the address
    string internal name;
    mapping(address => uint256) public balances;

    constructor(string memory _name) {
        name = _name;
    }

    function mint() public virtual {
        // balances[msg.sender] ++; // internal calling, msg.sender is the address of the contract,
        //not who sent the transaction
        balances[msg.sender]++; // sender of the transaction
    }

}

contract MyToken is
    ERC20TokenExample //inheritance, no need to double deploy
{
    string public symbol; // take parameters from the parent contract
    // string public name = "My token";  //overwrite the parent functionality
    address[] public owners;
    uint256 owner_count;
    constructor(string memory _name, string memory _symbol) ERC20TokenExample(_name) {
        symbol = _symbol;

    }

    function mint() public override {
        super.mint();
        owner_count++;
        owners.push(msg.sender);
    }

}
