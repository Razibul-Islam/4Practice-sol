// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract A{
    function message() public pure virtual returns(string memory){
        return "Hello From A";
    }
}

contract B is A{
    function message() public pure virtual  override returns(string memory){
        return "Hello From B";
    }
}

contract C is A{
    function message() public pure virtual  override returns(string memory){
        return "Hello From C";
    }
}

contract D is C,B {
    function message() public pure override(C,B) returns(string memory){
        return super.message();
    }
}