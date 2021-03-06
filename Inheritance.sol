pragma solidity ^0.8.11;

contract SafeMath {

    function add(int a, int b) internal pure returns (int) {
        int c = a + b;
        require(c >= a, "Addition: Integer overflow");
        return c;
    }

    function subtract(int a, int b) internal pure returns (int) {
        require(a >= b, "Subtract: Integer underflow");
        int c = a - b;
        return c;
    }

    function multiply(int a, int b) internal pure returns (int) {
        if (a == 0 || b == 0) {
            return 0;
        }
        int c = a * b;
        require(c / a == b, "Multiplication: Integer overflow");
        return c;
    }

}

contract Owned {

    address contractOwner;

    constructor() public {
        contractOwner = msg.sender;
    }

    modifier onlyOwner() {
        require(contractOwner == msg.sender, "Only Contract Owner is authorized");
        _;
    }

    function changeOwner(address newOwner) public onlyOwner {
       contractOwner = newOwner;
    }
}

contract SafeMathImplementation is Owned, SafeMath {

    int256 x;
    uint private lastStateChange;

    function stateVar() public onlyOwner returns(int) {
        x = add(x, int(now % 256));
        x = multiply(x, int(now - lastStateChange));
        x = subtract(x, int(block.gaslimit));
        lastStateChange = now;
        return x;
    }

}

