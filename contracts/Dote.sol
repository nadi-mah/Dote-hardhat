// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.2 ;

contract dote {

    
    address public owner; 

    struct Voter {
        address voterAdd;
        uint256 vote;
        bool voted;
    }
    struct Candidate {
        string candidateId;
        uint256 numberOfVotes;
    }

    mapping (address => Voter) voters;

    Candidate[] public candidates;
    address[] public haveVoted;
    

    modifier onlyOwner {
    require (msg.sender == owner);
     _;
    }

    constructor() {
    owner = msg.sender;
    }
    function addVoter (address _voter) public onlyOwner {
    voters [_voter] = Voter (_voter, 0, false);
    }

    function addCandidate(string memory _id) public   {
        candidates.push(Candidate(_id, 0));
    }


    function vote (uint256 _candidate)  public {
        require(voters[msg.sender].voted == false, "You have already voted");
        require(_candidate < candidates.length, "Candidate index is out of range");
        voters[msg.sender].vote = _candidate;
        voters[msg.sender].voted = true;
        candidates[_candidate].numberOfVotes += 1;
        haveVoted.push(msg.sender);
    }

    function winner ()view public returns (string memory){
        string memory theWinner;
        uint256 maxVote = 0;
        for (uint256 i=0; i < candidates.length; i++){
            if (candidates[i].numberOfVotes > maxVote){
                maxVote = candidates[i].numberOfVotes;
                theWinner = candidates[i].candidateId;
            }
        }
        return theWinner;
        }

    function showCandidates ()  public view returns(string[] memory){
        string[] memory candidatesName  = new string[](candidates.length);
        for (uint256 i = 0; i < candidates.length; i++){
            candidatesName[i] = candidates[i].candidateId;
        }
        return candidatesName;
    }

    function showVoters () view public  returns (address[] memory) {
        return haveVoted;
    }


}