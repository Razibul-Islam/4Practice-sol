// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract StudentManagementSystem {
    struct Student {
        string name;
        uint256 age;
        uint256[] grades;
    }

    mapping(uint256 => Student) private students;

    // Add Events for adding students
    event StudentAdded(string name, uint256 age, uint256 id);

    // Add Modifire that Same id can't add twice
    modifier CheckID(uint256 id) {
        require(
            bytes(students[id].name).length == 0,
            "This Student is already exits"
        );
        _;
    }

    function addStudent(
        uint256 id,
        string memory name,
        uint256 age,
        uint256[] memory grades
    ) public CheckID(id) {
        students[id] = Student(name, age, grades);
        emit StudentAdded(name, age, id);
    }

    function getStudent(uint256 id)
        public
        view
        returns (
            string memory name,
            uint256 age,
            uint256[] memory grades
        )
    {
        require(bytes(students[id].name).length > 0, "Student not found!");
        Student storage student = students[id];
        return (student.name, student.age, student.grades);
    }
}


