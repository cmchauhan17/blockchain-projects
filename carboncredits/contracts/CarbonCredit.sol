pragma solidity ^0.4.24;

contract CarbonCredit {


    //Factors required for calculation as well as the contract details
    string public orgName;
    uint32 public noOfVehicles;
    uint32 public avgDistance;
    uint32 public orgVehicleWeight;
    uint32 public orgCargoWeight;
    uint32 public carbonCreditValue;


    function inputDetails(string _orgName, uint32 _noOfVehicles, uint32 _avgDistance, uint32 _orgVehicleWeight, uint32 _orgCargoWeight) public{
        orgName = _orgName;
        noOfVehicles = _noOfVehicles;
        avgDistance = _avgDistance;
        orgVehicleWeight = _orgVehicleWeight;
        orgCargoWeight = _orgCargoWeight;

        if (orgVehicleWeight > 500){
            carbonCreditValue = noOfVehicles * avgDistance * (orgVehicleWeight + orgCargoWeight) * 143;
        }
        else{
            carbonCreditValue = noOfVehicles * avgDistance * (orgVehicleWeight + orgCargoWeight) * 307;
        }
    }

    function getCarbonCredits() external view returns (int) { 
        return carbonCreditValue/1000000; 
    }
}