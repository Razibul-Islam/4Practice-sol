// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract TodoList {
    // Use struct for Title and Description
    struct Task {
        string description;
        bool isComplete;
    }

    // Array for task
    Task[] private task;

    // Task complete event
    event taskComplete(uint256 indexed id, string description);

    // Modifire
    modifier checkAlreadyComplete(uint256 id) {
        require(id < task.length, "Task Does not Exit");
        require(!task[id].isComplete, "Task is already completed");
        _;
    }

    // Add New Task
    function addTask(string memory _description) public {
        task.push(Task(_description, false));
    }

    // Mark as complete
    function completeTask(uint256 _id) public {
        task[_id - 1].isComplete = true;
    }

    // Function to get task count
    function CountTask() public view returns (uint256) {
        return task.length;
    }

    // Task details Function
    function getDetails(uint256 _id) public view returns (string memory, bool) {
        require(_id - 1 < task.length, "task is not available");
        return (task[_id - 1].description, task[_id - 1].isComplete);
    }
}
