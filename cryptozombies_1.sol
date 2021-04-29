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

    // Create a public function with two parameters
    function createZombie(string memory _name, uint _dna) public {
        // Create Zombie and add to zombie array
        zombies.push(Zombie(_name, _dna));
    }
}   