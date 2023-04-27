pragma solidity >=0.5.0 <0.6.0;     // We can use a range of compiler versions of solidity like this!

contract ZombieFactory {   // Initialized the contract using ```Contract``` keyword

    event NewZombie(uint zombieId, string name, uint dna);      // Here we created a new event keyword, this will be used to acknowledge that something has happened in the blockchain

    // declared uint variables 'dnaDigits' and 'dnaModules'
    uint dnaDigits = 16;       
    uint dnaModulus = 10 ** dnaDigits;

    //  Declared a struct
    struct Zombie {
        string name;
        uint dna;
    }

    //  Declared an array with the "Zombie" data type
    Zombie[] public zombies;

    // Initialized two mappings 'zombieToOwner' from uint256 to address and 'ownerZombieCount' from address to uint256
    mapping (uint256 => address) public zombieToOwner;     
    mapping (address => uint256) public ownerZombieCount;

    // Initialized a function "_createZombie" its a private function and hence we used the '_' in the starting of the function name as its a convention
    function _createZombie(string memory _name, uint _dna) private {
        uint id = zombies.push(Zombie(_name, _dna)) - 1;
        emit NewZombie(id, _name, _dna);
    }

    function _generateRandomDna(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomZombie(string memory _name) public {
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

}
