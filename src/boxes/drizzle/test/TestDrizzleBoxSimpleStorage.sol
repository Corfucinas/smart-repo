pragma solidity >=0.4.21 <0.7.0;

import 'truffle/Assert.sol';
import 'truffle/DeployedAddresses.sol';
import '../contracts/DrizzleBoxSimpleStorage.sol';

contract TestSimpleStorage {
    function testItStoresAValue() public {
        SimpleStorage DrizzleBoxSimpleStorage = SimpleStorage(
            DeployedAddresses.SimpleStorage()
        );

        DrizzleBoxSimpleStorage.set(89);

        uint256 expected = 89;

        Assert.equal(
            DrizzleBoxSimpleStorage.storedData(),
            expected,
            'It should store the value 89.'
        );
    }
}
