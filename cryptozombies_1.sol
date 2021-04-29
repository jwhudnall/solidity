pragma solidity >=0.5.0;

contract ZombieFactory {
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
        // Create Zombie and add to zombie array
        zombies.push(Zombie(_name, _dna));
    }

    // Private, view function
    function _generateRandomDna(string memory _str) private view returns (uint) {
        // Generate pseudo-random hex of _str as 16-digit uint
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }
}   