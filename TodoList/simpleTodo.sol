// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract simpleTodo{
    struct Task{
        uint256 id;
        string content;
        bool isComplete;
    }

    mapping (address => Task[]) private tasks;

    event created(uint256 id, string content);
    event complete(uint256 id);
    event Update(uint256 id, string content);
    event Delete(uint256 id);

    uint256 private taskId;

    modifier validTask(uint256 id){
        require(id < tasks[msg.sender].length,"Invalid task Id");
        _;
    }

    function addTodo(uint256 id, string memory content) public returns(bool){
        tasks[msg.sender].push(Task(id,content,false));
        emit created(id, content);
        taskId++;
        return true;
    }

    function completeTask(uint256 id) public validTask(id) {
        tasks[msg.sender][id-1].isComplete = true;
        emit complete(id);
    }

    function deleteTask(uint256 id) public validTask(id) {
        uint256 lastIndex = tasks[msg.sender].length - 1;
        if(id != lastIndex){
            tasks[msg.sender][id] = tasks[msg.sender][lastIndex];
        }
        tasks[msg.sender].pop();
        emit Delete(id);
    }

    function update(uint256 id, string memory newContent) public validTask(id){
        tasks[msg.sender][id].content = newContent;
        emit Update(id, newContent);
    }

    function getMyTask() public view returns(Task[] memory){
        return tasks[msg.sender];
    }
}