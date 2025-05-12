// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Voting{

    mapping (address => string) private candidates;
    mapping (address => uint256) private voteCount;
    mapping (address => bool) private isVoted;

    event voteCasted(address cand, uint256 count);

    modifier voteOnce(address addr){
        require(!isVoted[addr],"Already Voted");
        _;
    }

    function addCandidate(address add, string memory name) public returns(bool){
        candidates[add] = name;
        return true;
    }

    function vote(address add) public voteOnce(msg.sender){
        isVoted[msg.sender] = true;
        voteCount[add] += 1;
        emit voteCasted(add, voteCount[add]);
    }

    function checkVote(address add) public view returns(uint256){
        return voteCount[add];
    }
}