// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract Storage {
    uint256 number;

    struct VehicleLicense {
        string vin;
        address owner;
        string plateNumber;
    }

    mapping (string => VehicleLicense) public vehicleLicenses;

    event VehicleRegistred(string vin, address owner, string plateNumber);
    event VehicleDeregistred(string vin);

    function registerVehicle(string memory _vin, string memory _plateNumber) public {
        require(
            vehicleLicenses[_vin].owner == address(0x0), 
            "License for given VIN already exists"
        );

        vehicleLicenses[_vin] = VehicleLicense(_vin, msg.sender, _plateNumber);
        emit VehicleRegistred(_vin, msg.sender, _plateNumber);
    }

    function deregisterVehicle(string memory _vin) public {
        require(
            vehicleLicenses[_vin].owner == msg.sender,
            "License with given VIN is not exist or assigned to another owner"
        );

        delete vehicleLicenses[_vin];
        emit VehicleDeregistred(_vin);
    }

    /**
     * @dev Store value in variable
     * @param num value to store
     */
    function store(uint256 num) public {
        number = num;
    }

    /**
     * @dev Return value
     * @return value of 'number'
     */
    function retrieve() public view returns (uint256) {
        return number;
    }
}
