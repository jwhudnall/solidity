pragma solidity >=0.5.0 <0.8.5;

import "./ownable.sol";

contract ZombieFactory is Ownable{

    // declare event to communicate to front-end
    event NewZombie(uint zombieId, string name, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;
    uint cooldownTime = 1 days; 

    struct Zombie {
        string name;
        uint dna;
        uint32 level;
        uint32 readyTime;
    }
    // Create a public array of Zombie structs
    Zombie[] public zombies;

    // Mapping to store zombie ownership
    mapping (uint => address) public zombieToOwner;
    mapping (address => uint) ownerZombieCount;


    // Create a private function with two parameters
    function _createZombie(string memory _name, uint _dna) internal {
        // Create zombie id that equals the index of the array after Zombie is added
        uint id = zombies.push(Zombie(_name, _dna, 1, uint32(now + cooldownTime))) - 1;

        // update owner mapping and increment zombie count
        zombieToOwner[id] = msg.sender;
        ownerZombieCount[msg.sender]++;
        // fire event
        emit NewZombie(id, _name, _dna);
    }

    // Private, view function
    function _generateRandomDna(string memory _str) private view returns (uint) {
        // Generate pseudo-random hex of _str as 16-digit uint
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    // public function that takes an input (zombie name)
    // and uses the name to create a zombie with random DNA
    function createRandomZombie(string memory _name) public {
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }
}   