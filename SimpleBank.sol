pragma solidity ^0.8.11;

contract SimpleBank {

    mapping(address => uint) bankBalance;

    event VaultDeposit(address accountHolder, uint deposit, uint newBalance);
    event VaultWithdrawal(address accountHolder, uint withdrawal, uint newBalance);

    address contractOwner;


    constructor() public payable {
        contractOwner = msg.sender;
    }

    modifier onlyOwner() {
        require(contractOwner == msg.sender, "Only Bank Owner is Authorized");
        _;
    }

    function deposit() public payable {
        require(bankBalance[msg.sender] + msg.value >= bankBalance[msg.sender], "Addition: Balance Overflow");
        bankBalance[msg.sender] += msg.value;
        uint amount = msg.value;
        emit VaultDeposit(msg.sender, amount, bankBalance[msg.sender]);
    }

    function withdraw(uint amount) public returns (bool) {
        require(amount <= bankBalance[msg.sender], "Subtraction: Balance Underflow");
        bankBalance[msg.sender] -= amount;
        emit VaultWithdrawal(msg.sender, amount, bankBalance[msg.sender]);
        msg.sender.transfer(amount);
        return true;
    }

    function getBalance() public view returns (uint) {
        return bankBalance[msg.sender];
    }

    function vaultBalance() public view onlyOwner returns (uint) {
        return address(this).balance;
    }

}
