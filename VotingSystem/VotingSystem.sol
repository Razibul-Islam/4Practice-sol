// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract VotingSystem {
    // store candidate Names in array
    string[] private CandidateNames;

    address private owner;

    // Constructor for initial
    constructor() {
        owner = msg.sender;
    }

    // store voting for each candidate
    mapping(string => uint256) private candidateVotes;

    // check is candidate has voted
    mapping(address => bool) private isVoted;

    // Add Event
    event Voted(string candidateName, uint256 totalVote);

    // Add Modifire for check Vote Duplicate
    modifier checkVote() {
        require(!isVoted[msg.sender], "Already Voted");
        _;
    }

    // Add Modifire for check owner
    modifier checkOwner(){
        require(owner == msg.sender, "You are not the Owner");
        _;
    }

    // Add Candidate
    function addCandidate(string memory name) public checkOwner{
        CandidateNames.push(name);
        candidateVotes[name] = 0;
    }

    // Function to vote a candidate
    function vote(string memory candidateName) public checkVote {
        require(candidateVotes[candidateName] >= 0, "Candidate Does not exits");

        candidateVotes[candidateName] += 1;
        isVoted[msg.sender] = true;

        emit Voted(candidateName, candidateVotes[candidateName]);
    }

    // Get total Candidate number
    function totalNumberCandidate() public view checkOwner returns (uint256) {
        return CandidateNames.length;
    }

    // Check Vote Count for a candidate
    function totalVote(string memory name) public view checkOwner returns (uint256) {
        return candidateVotes[name];
    }
}
