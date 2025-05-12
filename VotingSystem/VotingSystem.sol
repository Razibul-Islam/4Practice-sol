// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// contract VotingSystem {
//     // store candidate Names in array
//     string[] private CandidateNames;

//     address private owner;

//     // Constructor for initial
//     constructor() {
//         owner = msg.sender;
//     }

//     // store voting for each candidate
//     mapping(string => uint256) private candidateVotes;

//     // check is candidate has voted
//     mapping(address => bool) private isVoted;

//     // Add Event
//     event Voted(string candidateName, uint256 totalVote);

//     // Add Modifire for check Vote Duplicate
//     modifier checkVote() {
//         require(!isVoted[msg.sender], "Already Voted");
//         _;
//     }

//     // Add Modifire for check owner
//     modifier checkOwner(){
//         require(owner == msg.sender, "You are not the Owner");
//         _;
//     }

//     // Add Candidate
//     function addCandidate(string memory name) public checkOwner{
//         CandidateNames.push(name);
//         candidateVotes[name] = 0;
//     }

//     // Function to vote a candidate
//     function vote(string memory candidateName) public checkVote {
//         require(candidateVotes[candidateName] >= 0, "Candidate Does not exits");

//         candidateVotes[candidateName] += 1;
//         isVoted[msg.sender] = true;

//         emit Voted(candidateName, candidateVotes[candidateName]);
//     }

//     // Get total Candidate number
//     function totalNumberCandidate() public view checkOwner returns (uint256) {
//         return CandidateNames.length;
//     }

//     // Check Vote Count for a candidate
//     function totalVote(string memory name) public view checkOwner returns (uint256) {
//         return candidateVotes[name];
//     }
// }


contract DecentralizedVotingSystem {
    struct Candidate {
        uint256 Id;
        string name;
        uint256 voteCount;
    }

    address private owner;
    uint256 private startTime;
    uint256 private endTime;
    uint256 private electionId;
    string private electionName;

    mapping(uint256 => Candidate) private candidates;
    mapping(address => bool) private hasVoted;

    event voted(
        address indexed voter,
        uint256 candidateId,
        string candidateName,
        uint256 voteCount
    );
    event ElectionStarted(
        uint256 electionId,
        string electionName,
        uint256 stratTime,
        uint256 endTime
    );
    event ElectionEnded(
        uint256 electionId,
        string electionName,
        uint256 endTime
    );

    constructor(uint256 _id, string memory _name) {
        electionId = _id;
        electionName = _name;
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Your are not the owner");
        _;
    }

    modifier electionOnGoing() {
        require(
            block.timestamp >= startTime && block.timestamp <= endTime,
            "Election is not ongoing"
        );
        _;
    }

    function addCandidate(
        uint256 _id,
        string memory _name
    ) public onlyOwner electionOnGoing {
        require(candidates[_id].Id == 0, "You have already added as candidate");
        candidates[_id] = Candidate(_id, _name, 0);
    }

    function startElection(
        uint256 _startTime,
        uint256 _endTime
    ) public onlyOwner {
        require(_startTime < _endTime, "Start time must be less than end time");
        startTime = _startTime;
        endTime = _endTime;
        emit ElectionStarted(electionId, electionName, startTime, endTime);
    }

    function endElection() public onlyOwner electionOnGoing {
        endTime = block.timestamp;
        emit ElectionEnded(electionId, electionName, endTime);
    }

    function vote(uint256 _candidateId) public electionOnGoing {
        require(!hasVoted[msg.sender], "You have already voted");
        require(candidates[_candidateId].Id != 0, "Candidate not fount");

        candidates[_candidateId].voteCount += 1;
        hasVoted[msg.sender] = true;

        emit voted(
            msg.sender,
            _candidateId,
            candidates[_candidateId].name,
            candidates[_candidateId].voteCount
        );
    }

    function getCandidate(
        uint256 _candidateId
    ) public view returns (Candidate memory) {
        require(candidates[_candidateId].Id != 0, "Candidate Not Found");
        return candidates[_candidateId];
    }

    function getElectionDetails()
        public
        view
        returns (uint256, string memory, uint256, uint256)
    {
        return (electionId, electionName, startTime, endTime);
    }
}