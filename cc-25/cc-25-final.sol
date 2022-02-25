pragma solidity ^0.4.24;

contract CarbonCredit {


    //Factors required for calculation as well as the contract details
    string public organisationName;
    uint32 public CCValue_SP;
    uint32 public CCValue_Elect;
    uint32 public CCValue_EmployeeCommu;
    uint32 public CCValue_ProductTrans;
    uint32 public CCValue_PurchasedGas;
    uint32 public CCValue_PurchasedCC;

    //Sourcing and Procurement
    uint32 public distanceCovered;
    string public transportationMode;
    uint32 public vehicleWeight;
    uint32 public numberOfVehicles;
    uint32 public cargoWeight;

    //Electricity
    uint32 public unitsOfElectricity;
    string public typeOfEnergy;

    //Employee Commute
    string public typeOfTravel;
    string public modeOfTransportInComumute;
    uint32 public totalDistanceTravelled;

    //Product Transport
    uint32 public enterTotalDistanceCovered;
    string public modeOfTransportInProduct;
    uint32 public weightOfVehiclesInProduct;
    uint32 public weightOfCargoInProduct;
    uint32 public noOfVehiclesInProduct;

    //Purchased Gases
    string public typeOfGasPurchased;
    uint32 public enterQuantityPurchasedInGases;

    //REC or Greenpower Offset
    string public typeOfPowerUsed;
    uint32 public purchasedQuantityOfCredit;

    
    //input function for sourcing and procurement
    function input_SourceProcure(string _organisationName, uint32 _distanceCovered, string _transportationMode, uint32 _vehicleWeight, uint32 _numberOfVehicles,
    uint32 _cargoWeight) public {
        organisationName = _organisationName;
        distanceCovered = _distanceCovered;
        transportationMode = _transportationMode;
        vehicleWeight = _vehicleWeight;
        numberOfVehicles = _numberOfVehicles;
        cargoWeight = _cargoWeight;

        //conversion formula

        if (vehicleWeight > 500){
            CCValue_SP = (numberOfVehicles * distanceCovered * (vehicleWeight + cargoWeight) * 143)/1000;
        } else {
            CCValue_SP = (numberOfVehicles * distanceCovered * (vehicleWeight + cargoWeight) * 307)/1000;
        }
    }

    //input function for electricity
    function input_Elect(uint32 _unitsOfElectricity, string _typeOfEnergy) public{
        unitsOfElectricity = _unitsOfElectricity;
        typeOfEnergy = _typeOfEnergy;
        
        //Conversion Formula (CO2 is in KGS Conversion - NonRen 1KWh = 0.91KG CO2; Ren 1KWh = 0.05KG CO2)
        if ((keccak256(abi.encodePacked(typeOfEnergy)) == keccak256(abi.encodePacked("renewable")))){
            CCValue_Elect = (unitsOfElectricity * 5)/100;
        } else {
            CCValue_Elect = (unitsOfElectricity * 91)/100;
        }
    }

    //input function for employee commute
    function input_EmployeeComm(string _typeOfTravel, string _modeOfTransportInComumute, uint32 _totalDistanceTravelled) public{
        typeOfTravel = _typeOfTravel;
        modeOfTransportInComumute = _modeOfTransportInComumute;
        totalDistanceTravelled = _totalDistanceTravelled;
        
        //Conversion Formula (CO2 is in KGS - Road per passenger per mile - 0.368 KG CO2; Rail per passenger per mile - 0.144 KG CO2; Air per
        // passenger per mile - 0.275 KG CO2)
        if ((keccak256(abi.encodePacked(modeOfTransportInComumute)) == keccak256(abi.encodePacked("air")))){
            CCValue_EmployeeCommu = (totalDistanceTravelled * 275)/1000;
        } else if ((keccak256(abi.encodePacked(modeOfTransportInComumute)) == keccak256(abi.encodePacked("rail")))){
            CCValue_EmployeeCommu = (totalDistanceTravelled * 144)/1000;
        } else if ((keccak256(abi.encodePacked(modeOfTransportInComumute)) == keccak256(abi.encodePacked("road")))){
            CCValue_EmployeeCommu = (totalDistanceTravelled * 368)/1000;
        }

    }

    //input function for product transport
    function input_productTrans(uint32 _enterTotalDistanceCovered, string _modeOfTransportInProduct, uint32 _weightOfVehiclesInProduct,
    uint32 _noOfVehiclesInProduct, uint32 _weightOfCargoInProduct) public{
        enterTotalDistanceCovered = _enterTotalDistanceCovered;
        modeOfTransportInProduct = _modeOfTransportInProduct;
        weightOfVehiclesInProduct = _weightOfVehiclesInProduct;
        noOfVehiclesInProduct = _noOfVehiclesInProduct;
        weightOfCargoInProduct = _weightOfCargoInProduct;
        
        //Conversion Formula (CO2 is in KGS - Road per passenger per mile - 0.368 KG CO2; Rail per passenger per mile - 0.144 KG CO2; Air per
        // passenger per mile - 0.275 KG CO2)
        if ((keccak256(abi.encodePacked(modeOfTransportInProduct)) == keccak256(abi.encodePacked("road")))){
            CCValue_ProductTrans = (noOfVehiclesInProduct * enterTotalDistanceCovered * (weightOfVehiclesInProduct + weightOfCargoInProduct) * 368)/1000;
        } else if ((keccak256(abi.encodePacked(modeOfTransportInProduct)) == keccak256(abi.encodePacked("rail")))){
            CCValue_ProductTrans = (enterTotalDistanceCovered * 144)/1000;
        } else if ((keccak256(abi.encodePacked(modeOfTransportInProduct)) == keccak256(abi.encodePacked("air")))){
            CCValue_ProductTrans = (enterTotalDistanceCovered * 275)/1000;
        }

    }


    //input function for purchased gases
    function input_purchasedGas(string _typeOfGasPurchased, uint32 _enterQuantityPurchasedInGases) public{
        typeOfGasPurchased = _typeOfGasPurchased;
        enterQuantityPurchasedInGases = _enterQuantityPurchasedInGases;
        
        //Conversion Formula (CO2 is in KGS - 1KG CO2 -> 1KG CO2; 1KG CH4 -> 25KG CO2; 1KG N2O -> 298KG CO2; 1KG SF6 -> 22870KG CO2)
        if ((keccak256(abi.encodePacked(typeOfGasPurchased)) == keccak256(abi.encodePacked("co2")))){
            CCValue_PurchasedGas = enterQuantityPurchasedInGases;
        } else if ((keccak256(abi.encodePacked(typeOfGasPurchased)) == keccak256(abi.encodePacked("ch4")))){
            CCValue_PurchasedGas = (enterQuantityPurchasedInGases * 25);
        } else if ((keccak256(abi.encodePacked(typeOfGasPurchased)) == keccak256(abi.encodePacked("n2o")))){
            CCValue_PurchasedGas = (enterQuantityPurchasedInGases * 298);
        } else if ((keccak256(abi.encodePacked(typeOfGasPurchased)) == keccak256(abi.encodePacked("sf6")))){
            CCValue_PurchasedGas = (enterQuantityPurchasedInGases * 22870);
        }
        
    }

    //input function for REC or Greenpower Offset
    function input_GreenPowerOffset(string _typeOfPowerUsed, uint32 _purchasedQuantityOfCredit) public{
        typeOfPowerUsed = _typeOfPowerUsed;
        purchasedQuantityOfCredit = _purchasedQuantityOfCredit;

        CCValue_PurchasedCC = purchasedQuantityOfCredit;
        
        //Conversion Formula
    }

    function getCarbonCredits() external view returns (uint32) { 
        return (CCValue_SP + CCValue_Elect + CCValue_EmployeeCommu + CCValue_ProductTrans + CCValue_PurchasedGas - CCValue_PurchasedCC); 
    }
}

