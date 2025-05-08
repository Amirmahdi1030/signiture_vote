// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

//create contract
contract Voting{
    
    struct Candidate{
        uint id;
        string name;
        uint128 VoteCount;
    }
    
    //enter key and values
    mapping(uint=>Candidate)Candidates;
    mapping(address=>bool)Participants;
    
    uint128 CandidateCount;
    address owner;
    
    //access to owner
    constructor()public{
        owner=msg.sender;
    }
    
    //add candidate
    function AddCandidate(string memory _name) public returns(string memory){
        require(msg.sender==owner,"Error");                             //only owner can add Candidate
        CandidateCount++;                                               //CandidateCount can not to be zero
       Candidates[CandidateCount]=Candidate(CandidateCount,_name,0);              //create candidate
       return "Success";
    }
    
    //voting
    function Vote(uint id) public returns(string memory){
        require(id<=CandidateCount && id>0 ,"Candidate Not Found");           // id is <= count of Candidates
        require(Participants[msg.sender]==false);                            //each Candidate have one vote
        Candidates[id].VoteCount++;                                         //equal id with candidate vote
        Participants[msg.sender]=true;                                      //each Candidate have one vote
        return "Success";
    }
    
    //show winner
    function ShowWinner() view public returns(string memory){
            uint winnerID=0;                                                
            uint winnerVote=0;
            
            //every candidate have one vote from themselves
            for(uint i=1;i<=CandidateCount;i++){
                if(Candidates[i].VoteCount>=winnerVote){
                    winnerID=i;
                    winnerVote=Candidates[i].VoteCount;
                }
            }
            return Candidates[winnerID].name;
            
    }
    
}