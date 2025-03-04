// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract A{
    string public a;

    constructor(){
        a = "A constructor";
    }

}

contract B is A{
    string public b;

    constructor(){
        b = "B constructor";
    }

}
contract C is B{
    string public c;

    constructor(){
        c = "C constructor";
    }

}