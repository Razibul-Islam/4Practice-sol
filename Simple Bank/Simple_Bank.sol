// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract simpleBank{
    mapping (address => uint256) private balances;

    address private owner;
    constructor (){
        owner = msg.sender;
    }

    modifier checkOwner(){
        require(owner == msg.sender,"You are not the owner");
        _;
    }

    function deposit(address add,uint256 amount) public returns(bool) {
        balances[add] += amount;
        return true;
    }

    function checkBalance(address add) public view checkOwner returns(uint256){
        return balances[add];
    }
}