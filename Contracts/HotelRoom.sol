// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HotelRoom {

    enum Status {Vacant, Occupied}
    Status public currentStatus;

    event Occupied(address occupant, uint value);
    address payable public owner;

    constructor(){
        owner = payable (msg.sender);
        currentStatus = Status.Vacant;
    }

    modifier ifRoomIsVacant {
        require(currentStatus == Status.Vacant, "Room is not available.");
        _;    
    }

    modifier checkPayment(uint _amount){
        require(msg.value >= _amount, "Min. 2 Ether is required.");
        _;
    }

    function bookRoom() public payable ifRoomIsVacant checkPayment(2 ether) {
        currentStatus = Status.Occupied;
        // owner.transfer(msg.value);
        (bool sent, bytes memory data) = owner.call{value: msg.value}("");
        require(sent);
        emit Occupied(msg.sender, msg.value);
    }
}