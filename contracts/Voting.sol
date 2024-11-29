// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    address public organizer;
    uint public totalVotes;

    struct Candidate {
        string name;
        uint voteCount;
    }

    struct Voter {
        bool hasVoted;
        uint candidateIndex;
    }

    Candidate[] public candidates;
    mapping(address => Voter) public voters;

    constructor(string[] memory candidateNames) {
        organizer = msg.sender;
        for (uint i = 0; i < candidateNames.length; i++) {
            candidates.push(Candidate({name: candidateNames[i], voteCount: 0}));
        }
    }

    modifier onlyOrganizer() {
        require(msg.sender == organizer, "Only organizer can execute this.");
        _;
    }

    function vote(uint candidateIndex) public {
        require(!voters[msg.sender].hasVoted, "You have already voted.");
        require(candidateIndex < candidates.length, "Invalid candidate.");

        voters[msg.sender] = Voter({hasVoted: true, candidateIndex: candidateIndex});
        candidates[candidateIndex].voteCount++;
        totalVotes++;
    }

    function getCandidates() public view returns (Candidate[] memory) {
        return candidates;
    }

    function getVoteCount(uint candidateIndex) public view returns (uint) {
        return candidates[candidateIndex].voteCount;
    }
}
