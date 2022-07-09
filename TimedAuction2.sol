pragma solidity ^0.8.11;

contract TokenAuction {
    uint durationTime;
    address owner;
    mapping (address => uint) tokenBalances;
    uint public initialSupply;
    uint rateOfTokensToGivePerEth;

    event Auction(address tokenHolder, uint cost, uint tokenBalance);

    constructor() public payable {
        uint currentBlock = block.number;
        durationTime = currentBlock + 1;
        owner = msg.sender;
        initialSupply = 1000;
        tokenBalances[owner] = initialSupply;
        rateOfTokensToGivePerEth = 10;
    }

    modifier timeCheck() {
        require(durationTime >= block.number, "Auction Time is Over");
        _;
    }

    modifier onlyOwner() {
        require(owner == msg.sender, "Only Auction Owner is authorized");
        _;
    }
