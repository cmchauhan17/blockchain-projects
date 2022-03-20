pragma solidity ^0.4.26;

contract inputData {

    //creating a factory of data stored on blockchain i.e. creating an array which will store all data hash address
    address [] public storedData;

    //event creating bcs of promise to deliver us the newdata hash address
    event ContractCreated(address contractAddress);

    function addData(string _commitment, string _dateofCommitment) public{
        address newDataAdded = new retrieveData(msg.sender, _commitment, _dateofCommitment);

        //emits the event
        emit ContractCreated(newDataAdded);

        //saving the address so that a frontend client can access it
        storedData.push(newDataAdded);
    }

    //helper function to so your webClient can easily retrieve all datahash address created by this factory
    function getAddressOfInputData() public view returns (address []){
        return storedData;
    }
}

contract retrieveData {
    // You will declare your global vars here

    // Set owner public var, so everyone can see who owns the contract
    address public owner;

    //Marriage contract details
    string public commitment;
    string public dateofCommitment;

    constructor(address _owner, string _commitment, string _dateofCommitment) public {
        // You will instantiate your contract here
        owner = _owner;
        commitment = _commitment;
        dateofCommitment = _dateofCommitment;
    }

    function getCommitment() external view returns (string) { 
        return commitment; 
    }

    function getDateofCommitment() external view returns (string) { 
        return dateofCommitment; 
    }

    function getAccountAddress() external view returns (address) { 
        return owner; 
    }


}
