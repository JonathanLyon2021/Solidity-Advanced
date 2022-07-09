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
    function buyPet(string memory customer,
    uint cAge,
    string memory cGender,
    string memory animal)
    public onlyAllowed(animal)
    returns(bool successfulTransaction) {

        require(pets[animal] > 0, "Animal is no longer in stock");

        if (isCustomer(customer)) {
            require(keccak256(bytes(Customers[customer].pet)) == keccak256(bytes("RETURNED")),
            "Only One pet for a Lifetime");

        } else if (keccak256(bytes(cGender)) == keccak256(bytes("male"))) {

            require(keccak256(bytes(animal)) == keccak256(bytes("dog"))
            || keccak256(bytes(animal)) == keccak256(bytes("fish")),
                "You, Sir, are only allowed a pet Dog or Fish");
            Customers[customer].index = allCustomers.push(customer)-1;

        } else if (keccak256(bytes(cGender)) == keccak256(bytes("female")) && cAge < 40) {

            require(keccak256(bytes(animal)) != keccak256(bytes("cat")), "You, Madam, are not allowed a Cat yet");
            Customers[customer].index = allCustomers.push(customer)-1;
        }

        Customers[customer].gender = cGender;
        Customers[customer].age = cAge;
        Customers[customer].pet = animal;
        Customers[customer].time = block.timestamp;

        pets[animal]--;
        return true;
    }
