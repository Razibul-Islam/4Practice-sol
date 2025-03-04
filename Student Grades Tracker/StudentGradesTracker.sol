// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StudentGradesTracker{
    mapping (address => uint[]) private grades;

    event gradeAdded(address student, uint grade);

    function addGrade(uint grade) public {
        grades[msg.sender].push(grade);
        emit gradeAdded(msg.sender, grade);
    }

    function getGrades(address student) public view returns(uint[] memory) {
        require(student == msg.sender,"This student is not added");
        return grades[student];
    }
}