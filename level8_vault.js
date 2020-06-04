/*********vault.sol********

pragma solidity ^0.5.0;

contract Vault {
  bool public locked;
  bytes32 private password;

  constructor(bytes32 _password) public {
    locked = true;
    password = _password;
  }

  function unlock(bytes32 _password) public {
    if (password == _password) {
      locked = false;
    }
  }
}

**********/

//solution

web3.eth.getStorageAt(instanceAddress, 1, function(err, res) {
    console.log('password: '+res);
});