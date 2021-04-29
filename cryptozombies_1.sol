pragma solidity >=0.5.0;

contract ZombieFactory {

    // declare event to communicate to front-end
    event NewZombie(uint zombieId, string name, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
    }
    // Create a public array of Zombie structs
    Zombie[] public zombies;

    // Create a private function with two parameters
    function _createZombie(string memory _name, uint _dna) private {
        // Create zombie id that equals the index of the array after Zombie is added
        // fire event
        uint id = zombies.push(Zombie(_name, _dna)) - 1;
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