// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//fallback is a special function in Solidity, runs automatically when:
//Ether is sent directly to the contract (without calling any function) OR
//A non-existent function is called on the contract.
//helps handle unexpected or stuck transactions

contract StudentData {
    struct Student {
        uint ID;
        string fName;
        string lName;
        uint marks; 
    }

    Student[] public students; // students array of Student struct, dynamic size
//public makes Solidity automatically create a getter function
//so anyone can view students(index) from outside.

	address owner;
//Stores the Ethereum address of the person who deployed the contract.
//Used to restrict access — only this address can add new records.

//modifier is like a function, it creates a rule/condition
//which is checked everytime a function with that rule is called
    modifier onlyOwner { //modifier named onlyowner created
        require(owner == msg.sender); //require defines condition
        _; //signal for compiler to run rest of function code
    }

    constructor() {
        owner = msg.sender;
    }

    // Create a function to add new records
    function addNewRecords(uint _ID, string memory _fName, string memory _lName, uint _marks) public onlyOwner {
        students.push(Student(_ID, _fName, _lName, _marks)); 
    }

    // Fallback function
    fallback() external { //external= called by external users, other contracts
	//executing code (internal) - cannot call function
	//sending ether to smart contract (external) - function automatically called
        revert("StudentData: Fallback function called (Ether not accepted)");
    }

//pure= doesnt read or write data in the blockchain
//returns (dtype) = returns text message as output
//memory = temporary storage area, data kept there exists only while the function is running.
//Once the function finishes, anything stored in memory disappears.
	function isFallbackTriggered(bool simulateFallback) public pure returns (string memory) {
    require(!simulateFallback, "Fallback would have been triggered!");
    return "Fallback NOT triggered (normal operation).";
}
}
