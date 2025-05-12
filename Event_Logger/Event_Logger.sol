// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract EventLogger {

    uint public messageId;

    struct Log {
        uint id;
        string message;
        uint timestamp;
    }

    Log[] private logs;

    event MessageLogged(address indexed user, string message, uint timestamp);

    function logEvent(string memory message) public {
        logs.push(Log({
            id: messageId++,
            message: message,
            timestamp: block.timestamp
        }));

        emit MessageLogged(msg.sender, message, block.timestamp);
    }

    function getLogsCount() public view returns (uint) {
        return logs.length;
    }
}
