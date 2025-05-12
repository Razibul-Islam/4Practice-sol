// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract SimpleBank{
    mapping (address => uint256) private balances;

    event Deposited(address indexed account, uint256 amount);
    event Withdraw(address indexed account,uint256 amount);

    function deposit(address account, uint256 amount) public returns(bool){
        require(amount > 0,"Enter valid amount");

        balances[account] += amount;
        emit Deposited(account, amount);
        return true;
    }

    function withdraw(address account, uint256 amount) public returns(bool){
        require(amount < balances[account],"You have reached your amount");

        balances[account] -= amount;
        emit Withdraw(account, amount);
        return true;
    }

    function getBalance(address account) public view returns(uint256) {
        return balances[account];
    }
}