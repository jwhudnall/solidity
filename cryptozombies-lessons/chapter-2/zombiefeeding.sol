pragma solidity >=0.5.0;

import "./zombiefactory.sol";

// KittyInterface 
contract KittyInterface {
    function getKitty(uint256 _id) external view returns (
    bool isGestating,
    bool isReady,
    uint256 cooldownIndex,
    uint256 nextActionAt,
    uint256 siringWithId,
    uint256 birthTime,
    uint256 matronId,
    uint256 sireId,
    uint256 generation,
    uint256 genes
);

contract ZombieFeeding is ZombieFactory {
    // Create Public function
  // check zombie ownership
  // Create local variable
  function feedAndMultiply(uint _zombieId, uint _targetDna) public {
      require(msg.sender == zombieToOwner[msg.sender]);
      Zombie storage myZombie = zombies[_zombieId];

      / Make sure target DNA < 16 digits
    // Create a zombie whose DNA is the avg of the two
    _targetDna = _targetDna % dnaModulus;
    uint newDna = (myZombie.dna + _targetDna) / 2;
    _createZombie("NoName", newDna);
  }
  }
}