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
