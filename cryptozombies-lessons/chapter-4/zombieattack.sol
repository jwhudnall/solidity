pragma solidity >=0.5.0 <0.8.5;

import "./zombiehelper.sol";

contract ZombieAttack is ZombieHelper {
    // Incorporate "random" number function
  uint randNonce = 0;
  function randMod(uint _modulus) internal returns(uint) {
    randNonce++;
    return uint(keccak256(abi.encodePacked(now,msg.sender,randNonce))) % _modulus;
  }
}
