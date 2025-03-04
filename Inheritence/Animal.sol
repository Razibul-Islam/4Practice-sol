// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract animal{
    function makeSound() public pure virtual  returns(string memory){
        return "Some sound";
    }
}

contract Dog is animal{
    function makeSound() public pure override returns(string memory){
        return "Bark";
    }
}