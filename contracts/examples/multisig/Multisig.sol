// SPDX-License-Identifier: MIT

pragma solidity =0.7.3;

contract SimpleMultiSigContract {
    uint256 public nonce; // (only) mutable state
    uint256 public threshold; // immutable state
    mapping(address => bool) isOwner; // immutable state
    address[] public ownersArr; // immutable state

    function SimpleMultiSig(uint256 threshold_, address[] memory owners_)
        public
    {
        if (
            owners_.length > 10 ||
            threshold_ > owners_.length ||
            threshold_ == 0
        ) {
            revert;
        }

        for (uint256 i = 0; i < owners_.length; i++) {
            isOwner[owners_[i]] = true;
        }
        ownersArr = owners_;
        threshold = threshold_;
    }

    // Note that address recovered from signatures must be strictly increasing
    function execute(
        uint8[] memory sigV,
        bytes32[] memory sigR,
        bytes32[] memory sigS,
        address destination,
        uint256 value,
        bytes memory data
    ) public {
        if (sigR.length != threshold) {
            revert;
        }
        if (sigR.length != sigS.length || sigR.length != sigV.length) {
            revert;
        }

        // Follows ERC191 signature scheme: https://github.com/ethereum/EIPs/issues/191
        bytes32 txHash = sha3(
            bytes1(0x19),
            bytes1(0),
            this,
            destination,
            value,
            data,
            nonce
        );

        address lastAdd = address(0); // cannot have address(0) as an owner
        for (uint256 i = 0; i < threshold; i++) {
            address recovered = ecrecover(txHash, sigV[i], sigR[i], sigS[i]);
            if (recovered <= lastAdd || !isOwner[recovered]) revert;
            lastAdd = recovered;
        }

        // If we make it here all signatures are accounted for
        nonce = nonce + 1;
        if (!destination.call.value(value)(data)) {
            revert;
        }
    }

    fallback() external payable {}
}
