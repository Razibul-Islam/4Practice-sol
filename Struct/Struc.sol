// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StoreEmployee{
    struct employee{
        string name;
        uint age;
        uint salary;
    }


    employee[] public EmployeeRecords;

    function addEmployee(string memory name, uint age, uint salary) public {
        EmployeeRecords.push(employee(name,age,salary));
    }

    function retriveEmployee(uint index) public view returns(string memory, uint , uint){
        return (EmployeeRecords[index].name,EmployeeRecords[index].age, EmployeeRecords[index].salary);
    }

}