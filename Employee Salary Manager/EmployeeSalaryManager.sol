// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Company{
    mapping(address => uint) public salaries;

    address owner;
    constructor(){
        owner = msg.sender;
    }

    modifier checkOwner(){
        require(owner == msg.sender,"You are not the owner");
        _;
    }

    event SalaryUpdated(address employee, uint salary);

    function setSalary(address employee,uint salary) public checkOwner {
        salaries[employee] = salary;
        emit SalaryUpdated(employee, salary);
    }

    function getSalary(address employee) public view returns(uint){
        return salaries[employee];
    }
}

contract HRDepartment is Company{

    event SalaryIncreased(address employee, uint newSalary);

    function increaseSalary(address employee, uint newSalary) public checkOwner {
        salaries[employee] = newSalary;
        emit SalaryIncreased(employee, newSalary);
    }
}