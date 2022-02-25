pragma solidity ^0.4.24;

contract CarbonCredit {


    //Factors required for calculation as well as the contract details
    string public orgName;
    uint32 public noOfVehicles;
    uint32 public avgDistance;
    uint32 public orgVehicleWeight;
    uint32 public orgCargoWeight;
    uint32 public carbonCreditValue;
    string public transportationMode;

    string public name;
    uint32 public number1;
    uint32 public number2;
    string public transportationMode1;
    uint32 public result;

    function inputBasics(string _name, uint32 _number1, uint32 _number2, string _transportationMode1) public {
        name = _name;
        number1 = _number1;
        number2 = _number2;
        transportationMode1 = _transportationMode1;

        if ((keccak256(abi.encodePacked(transportationMode1)) == keccak256(abi.encodePacked("road")))){
            result = number1 * number2 * 143;
        } else if ((keccak256(abi.encodePacked(transportationMode1)) == keccak256(abi.encodePacked("rail")))){
            result = number1 * number2 * 307;
        } else if ((keccak256(abi.encodePacked(transportationMode1)) == keccak256(abi.encodePacked("air")))){
            result = number1 * number2 * 514;
        }

    }


    function inputDetails(string _orgName, string _transportationMode, uint32 _noOfVehicles, uint32 _avgDistance, uint32 _orgVehicleWeight, uint32 _orgCargoWeight) public{
        orgName = _orgName;
        noOfVehicles = _noOfVehicles;
        avgDistance = _avgDistance;
        orgVehicleWeight = _orgVehicleWeight;
        orgCargoWeight = _orgCargoWeight;
        transportationMode = _transportationMode;

        if ((keccak256(abi.encodePacked(transportationMode)) == keccak256(abi.encodePacked("road")))){
            carbonCreditValue = noOfVehicles * avgDistance * (orgVehicleWeight + orgCargoWeight) * 143;
        } else if ((keccak256(abi.encodePacked(transportationMode)) == keccak256(abi.encodePacked("rail")))){
            carbonCreditValue = noOfVehicles * avgDistance * (orgVehicleWeight + orgCargoWeight) * 307;
        } else if ((keccak256(abi.encodePacked(transportationMode)) == keccak256(abi.encodePacked("air")))){
            carbonCreditValue = noOfVehicles * avgDistance * (orgVehicleWeight + orgCargoWeight) * 514;
        }
    }

    function getCarbonCredits() external view returns (uint32) { 
        return carbonCreditValue+result; 
    }
}
