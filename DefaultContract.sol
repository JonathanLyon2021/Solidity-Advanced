pragma solidity ^0.5.8;

contract DepositContract {

    address owner;

    uint balances;

    event MoneySent(address contractAdd, uint amount);

    constructor() public payable {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(owner == msg.sender, "Only Contract Owner is authorized");
        _;
    }
}
