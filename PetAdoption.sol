pragma solidity ^0.8.11;



contract PetAdpotion {

    address owner;
    uint durationTime;
    mapping (string => bool) allowedPets;
    mapping (string => uint) pets;
    string[] private allPets;
    string[] private allCustomers;

    struct Customer {
        string gender;
        uint age;
        string pet;
        uint index;
        uint time;
    }

    mapping (string => Customer) private Customers;

    constructor() public {
        owner = msg.sender;

        allowedPets["fish"] = true;
        allowedPets["cat"] = true;
        allowedPets["dog"] = true;
        allowedPets["parrot"] = true;
        allowedPets["rabbit"] = true;

        pets["fish"] = 0;
        pets["cat"] = 0;
        pets["dog"] = 0;
        pets["parrot"] = 0;
        pets["rabbit"] = 0;
    }
     function isCustomer(string memory name)
    internal
    returns(bool)
    {
        if(allCustomers.length == 0) return false;

        return keccak256(bytes(name)) == keccak256(bytes(allCustomers[Customers[name].index]));
    }

    modifier onlyOwner() {
        require(owner == msg.sender, "Only Shop Owner is authorized");
        _;
    }

    modifier onlyAllowed(string memory animal) {
        require(allowedPets[animal], "Animal provided is not allowed");
        _;
    }

    modifier inTime(string memory customer) {
        durationTime = Customers[customer].time + 5 minutes;
        require(now <= durationTime, "Out of Time: Deadline to return your pet has been reached");
        _;
    }

    function addPets(string memory animal, uint amount) public onlyOwner onlyAllowed(animal) {
        pets[animal] += amount;
    }
