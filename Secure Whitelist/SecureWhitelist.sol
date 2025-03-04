// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SecureWhitelist {
    address private owner;
    mapping(address => bool) private addresses;

    constructor() {
        owner = msg.sender;
    }

    modifier checkOwner() {
        require(owner == msg.sender, "You are not the owner");
        _;
    }

    event WhiteListed(address user);

    function addWhiteList(address user) public checkOwner {
        addresses[user] = true;
        emit WhiteListed(user);
    }

    function checkWhiteList(address user) public view returns (bool) {
        return addresses[user];
    }
}
