//SPDX-License-Identifier: GPL-3.0
 
pragma solidity >=0.5.0 <0.9.0;

contract Lottery{

    address payable[] public players;
    address manager;

    constructor(){
        manager = msg.sender;
    }

    function getBalance() public view returns(uint){
        require(msg.sender == manager, "Only manager can get the balance");
        return address(this).balance;
    }

    receive() external payable{
        require(msg.value == 0.1 ether);
        require(manager != mas.sender, "Manager cannot participate in lottery");
        players.push(payable(msg.sender));
    }

    function getRandomnPlayerIndex() private view returns(uint){
        uint randomnIndex = uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, players.length)));
        return randomnIndex % players.length;
    }

    function pickWinner() public{
        require(msg.sender == manager, "Only manager can pick the winner");
        require(players.length >= 3, "Minimum 3 players required to pick winner");
        address payable winner = players[getRandomnPlayerIndex()];
        winner.transfer(getBalance());
        // Reset the lottery
        players = new address payable[](0);
    }

}
