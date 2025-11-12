// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
//pragma = compiler directive that gives instructions to compiler
//Solidity version 0.8.0 or higher

//contract similiar to class
contract Bank {
    uint256 private balance = 0; 
    //unsigned integer, balance stores money in wei, eth's smallest unit
    // Keep private for security
    address public accOwner;

    constructor() {
        accOwner = msg.sender;
//constructor runs only once when the contract is first deployed.
//msg.sender = the wallet address of the person calling this function.
//accOwner = the address that owns this contract (the one who deployed it).
//msg = inbuilt special object, box that automatically appears every time contract called
//That box holds some information about the transaction.
//So here, whoever deploys the contract becomes the owner of this bank account.
    }

//inifinite gas means compiler cant compute how much gas needed
//coz of payable functions, which involve sending/receiving Ether.
//payable → when function called, ether can be sent with it
    function Deposit() public payable {
        require(msg.sender == accOwner, "Only owner can deposit");
        //require checks a condition.
        //if true, function continues, else
        //the function stops and gives the message in quotes.
        //Here: only the owner (who deployed the contract) can deposit.

        require(msg.value > 0, "Amount must be > 0");
        //msg.value is how much Ether the caller sent, should be positive amount.
        balance += msg.value;
    }

    // Withdraw (specify amount, no Ether sent)
    //nonpayable: when function called, ether cannot be sent with it, only runs code

    function Withdraw(uint256 _amount) public {
        require(msg.sender == accOwner, "You are not the owner");
        require(balance >= _amount, "Insufficient balance");
        balance -= _amount;
        payable(msg.sender).transfer(_amount);
        //payable(msg.sender) → turns the caller’s address into one that can receive Ether.
        //.transfer(_amount) → sends the specified amount of Ether to them.
    }

    // Show balance (only owner can check)
    //view is used only for reading and values
    //returns is used to return or print a value, here uint256
    function showBalance() public view returns (uint256) {
        require(msg.sender == accOwner, "You are not the owner");
        return balance;
    }
}
