// SPDX-License-Identifier: MIT

pragma solidity =0.7.3;

// ----------------------------------------------------------------------------
// ERC Token Standard #20 Interface
// https://github.com/ethereum/EIPs/blob/master/EIPS/eip-20-token-standard.md
// ----------------------------------------------------------------------------
interface ERC20Interface {
    event Transfer(address indexed from, address indexed to, uint256 tokens);
    event Approval(
        address indexed tokenOwner,
        address indexed spender,
        uint256 tokens
    );

    function transfer(address to, uint256 tokens)
        external
        returns (bool success);

    function approve(address spender, uint256 tokens)
        external
        returns (bool success);

    function transferFrom(
        address from,
        address to,
        uint256 tokens
    ) external returns (bool success);

    function totalSupply() external view returns (uint128);

    function balanceOf(address tokenOwner)
        external
        view
        returns (uint256 balance);

    function allowance(address tokenOwner, address spender)
        external
        view
        returns (uint256 remaining);
}

library SafeMath {
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        assert(b <= a);
        return a - b;
    }

    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        assert(c >= a);
        return c;
    }
}

contract StandardTokenExample is ERC20Interface {
    string private _name = 'StandardTokenExample';
    string private _symbol = 'STE';
    uint128 private _decimals = 18;
    uint128 private _totalSupply = 1000000000;

    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowed;
    mapping(string => address) private _addressTable;

    event RegistrationSuccessful(uint256 nonce);
    event RegistrationFailed(uint256 nonce);

    using SafeMath for uint256;

    // solhint-disable-next-line
    constructor(
        string memory name,
        string memory symbol,
        uint128 decimals,
        uint128 initialSupply
    ) payable {
        _name = name;
        _symbol = symbol;
        _decimals = decimals;
        _totalSupply = initialSupply;
        _balances[msg.sender] = _totalSupply;
    }

    function name() external view returns (string memory) {
        return _name;
    }

    function symbol() external view returns (string memory) {
        return _symbol;
    }

    function totalSupply() external view override returns (uint128) {
        return _totalSupply;
    }

    function decimals() external view returns (uint128) {
        return _decimals;
    }

    function balanceOf(address tokenOwner)
        external
        view
        override
        returns (uint256)
    {
        return _balances[tokenOwner];
    }

    function balanceOf(string calldata tokenOwner)
        external
        view
        returns (uint256)
    {
        address userAddress;
        userAddress = _addressTable[tokenOwner];
        return _balances[userAddress];
    }

    function transfer(address receiver, uint256 numTokens)
        external
        override
        returns (bool)
    {
        require(numTokens <= _balances[msg.sender], 'Not enough balance.');
        _balances[msg.sender] = _balances[msg.sender].sub(numTokens);
        _balances[receiver] = _balances[receiver].add(numTokens);
        emit Transfer(msg.sender, receiver, numTokens);
        return true;
    }

    function transfer(string calldata receiver, uint256 numTokens)
        external
        returns (bool)
    {
        address receiverAddress;
        receiverAddress = _addressTable[receiver];
        require(numTokens <= _balances[msg.sender], 'Not enough balance.');
        _balances[msg.sender] = _balances[msg.sender].sub(numTokens);
        _balances[receiverAddress] = _balances[receiverAddress].add(numTokens);
        emit Transfer(msg.sender, receiverAddress, numTokens);
        return true;
    }

    function approve(address delegate, uint256 numTokens)
        external
        override
        returns (bool)
    {
        _allowed[msg.sender][delegate] = numTokens;
        emit Approval(msg.sender, delegate, numTokens);
        return true;
    }

    function approve(string calldata delegate, uint256 numTokens)
        external
        returns (bool)
    {
        address delegateAddress;
        delegateAddress = _addressTable[delegate];
        _allowed[msg.sender][delegateAddress] = numTokens;
        emit Approval(msg.sender, delegateAddress, numTokens);
        return true;
    }

    function allowance(address owner, address delegate)
        external
        view
        override
        returns (uint256)
    {
        return _allowed[owner][delegate];
    }

    function allowance(string calldata owner, string calldata delegate)
        external
        view
        returns (uint256)
    {
        address ownerAddress;
        ownerAddress = _addressTable[owner];
        address delegateAddress;
        delegateAddress = _addressTable[delegate];
        return _allowed[ownerAddress][delegateAddress];
    }

    function transferFrom(
        address owner,
        address buyer,
        uint256 numTokens
    ) external override returns (bool) {
        require(numTokens <= _balances[owner], 'Not enough balance.');
        require(
            numTokens <= _allowed[owner][msg.sender],
            'Not enough balance allowed.'
        );

        _balances[owner] = _balances[owner].sub(numTokens);
        _allowed[owner][msg.sender] = _allowed[owner][msg.sender].sub(
            numTokens
        );
        _balances[buyer] = _balances[buyer].add(numTokens);
        emit Transfer(owner, buyer, numTokens);
        return true;
    }

    function transferFrom(
        string calldata owner,
        string calldata buyer,
        uint256 numTokens
    ) external returns (bool) {
        address ownerAddress;
        ownerAddress = _addressTable[owner];
        address buyerAddress;
        buyerAddress = _addressTable[buyer];

        require(numTokens <= _balances[ownerAddress], 'Not enough tokens.');
        require(
            numTokens <= _allowed[ownerAddress][msg.sender],
            'Not enough balance allowed'
        );

        _balances[ownerAddress] = _balances[ownerAddress].sub(numTokens);
        _allowed[ownerAddress][msg.sender] = _allowed[ownerAddress][msg.sender]
            .sub(numTokens);
        _balances[buyerAddress] = _balances[buyerAddress].add(numTokens);
        emit Transfer(ownerAddress, buyerAddress, numTokens);
        return true;
    }

    function registerUser(string calldata user, uint256 nonce)
        external
        returns (bool)
    {
        if (_addressTable[user] == address(0)) {
            _addressTable[user] = msg.sender;
            emit RegistrationSuccessful(nonce);
            return true;
        } else {
            emit RegistrationFailed(nonce);
            return false;
        }
    }
}
