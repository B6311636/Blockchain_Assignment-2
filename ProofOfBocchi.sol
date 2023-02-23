// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

contract ProofOfBocchi {

    struct BocchiMetadata {
        string name;
        int price;
        uint256 timestamp;
        address owner;
    }

    mapping(bytes32 => BocchiMetadata) private listBocchi;

    // store the metadata for a Bocchi in the contract state
    function recordMetadata(string memory name, int price) public {
        bytes32 hash = hashing(name);
        require(listBocchi[hash].timestamp == 0, "Bocchi metadata already exists");
        listBocchi[hash] = BocchiMetadata(name, price, block.timestamp, msg.sender);
    }

    // SHA256 for Integrity
    function hashing(string memory name) private pure returns (bytes32) {
        return sha256(bytes(name));
    }

    // Function to get the metadata of a Bocchi
    function getBocchiMetadata(bytes32 hash) public view returns (string memory, int, uint256, address) {
        BocchiMetadata memory metadata = listBocchi[hash];
        require(metadata.timestamp > 0, "Bocchi metadata not found");
        return (metadata.name, metadata.price, metadata.timestamp, metadata.owner);
    }
}
