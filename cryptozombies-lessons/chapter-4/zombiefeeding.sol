pragma solidity >=0.5.0 <0.8.5;

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


  // Define kittyContract and add function to set address
  KittyInterface kittyContract;
  function setKittyContractAddress(address _address) external onlyOwner {
    kittyContract = KittyInterface(_address);
  }

  // Define trigger cooldown function
  function _triggerCooldown(Zombie storage _zombie) internal {
    _zombie.readyTime = uint32(now + cooldownTime);
  }

  // Define helper function to determine if Zombie is eligible for an action
  function _isReady(Zombie storage _zombie) internal view returns(bool) {
    return (_zombie.readyTime <= now);
  }

    // Create Public function
  // check zombie ownership
  // Create local variable
  function feedAndMultiply(uint _zombieId, uint _targetDna, string memory _species) internal {
      require(msg.sender == zombieToOwner[msg.sender]);
      Zombie storage myZombie = zombies[_zombieId];
      require(_isReady(myZombie));

      / Make sure target DNA < 16 digits
    // Create a zombie whose DNA is the avg of the two
    _targetDna = _targetDna % dnaModulus;
    uint newDna = (myZombie.dna + _targetDna) / 2;
    // Changes last 2 digits of zombie DNA to '99' if _species is 'kitty'
    if (keccak256(abi.encodePacked(_species)) == keccak256(abi.encodePacked("kitty")))) {
      newDna = newDna - newDna % 100 + 99;     
    }
    _createZombie("NoName", newDna);
    _triggerCooldown(myZombie);
  }
  // define function to retrieve kitty genes from contract
  function feedOnKitty(uint _zombieId, uint _kittyId) public {
    uint kittyDna;
    (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
    feedAndMultiply(_zombieId, kittyDna, "kitty");
  }
}