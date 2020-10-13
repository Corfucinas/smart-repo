// SPDX-License-Identifier: MIT

pragma solidity =0.7.3;

// pragma experimental ABIEncoderV2;
// pragma experimental SMTChecker;

// if the contract does not wants to be deployed, write 'abstract' before contract

contract HelloWorld {
    string public value; // public allows exposing the variable to functions
    // outside the program itself
    // this way we can avoid writing a function (ie 'function get()')
    string public default_value = 'default_value';
    string public constant constant_function = 'cannot_be_changed';
    bool public a_bool = true;
    bool public b_bool = false;
    int256 public one_int = -1;
    uint256 public another_int = 1;
    uint8 public small_number = 8;
    uint256 public bigger_number = 256;
    // Person[] public people; // Person acts like a class, people is an instance of an array.
    uint256 public people_count; //counter cache to increment, need to verify is there's not an API
    address owner; //address of who owns the contract
    uint256 opening_time = 1601567416; // time in Solidity is in seconds and start on Epoch

    mapping(uint256 => Person) public people; // Mapping instead of using People[]

    enum State { Waiting, Ready, Active }
    State public state; // this is a getter, assigns the enum to state

    constructor() {
        value = 'Hello World!';
        state = State.Waiting; // this is the default value of 'state'
        owner = msg.sender;
    }

    struct Person {
        uint256 _id;
        string _first_name;
        string _last_name;
    }

    // modifier only_owner() {
    //   assert(msg.sender == owner);
    //   // require(msg.sender == owner); // 'msg' is related to the metadata, require otherwise raises an error
    //   // Use "assert(x)" if you never ever want x to be false, not in any circumstance (apart from a bug in your code).
    //   //  Use "require(x)" if x can be false, due to e.g. invalid input or a failing external component.
    //   _; // handles all cases
    // }

    modifier onlyWhileOpen() {
        assert(block.timestamp >= opening_time);
        _; // handles all cases
    }

    function addPerson(string memory _first_name, string memory _last_name)
        public
        // only_owner
        onlyWhileOpen // a time in the future
    {
        incrementCount();
        people[people_count] = Person(people_count, _first_name, _last_name);
        // people.push(Person(_first_name, _last_name));  // Mapping is provided above
    }

    function incrementCount() internal {
        // internal
        people_count += 1;
    }

    // function get() public view returns (string memory) {
    //   return value;
    // }  // function can be saved by using a public initialized var

    function activate() public {
        state = State.Active;
    }

    function isActive() public view returns (bool) {
        return state == State.Active;
    }

    function set(string memory _value) public {
        value = _value;
    }
}
