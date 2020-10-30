// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.7.0;

// Import the library 'Roles'
import "./Roles.sol";

contract FarmerRole {
  using Roles for Roles.Role;

  // Define 2 events, one for Adding, and other for Removing
  event FarmerAdded(address indexed account);
  event FarmerRemoved(address indexed account);

  Roles.Role private farmers;

  function isFarmer(address account) public view returns (bool) {
    return farmers.has(account);
  }

  modifier onlyFarmer() {
    require(isFarmer(msg.sender),
    "Only Farmers can access this function.");
    _;
  }

  function addFarmer(address account) public {
    farmers.add(account);
    emit FarmerAdded(account);
  }

  function removeFarmer(address account) public {
    farmers.remove(account);
    emit FarmerRemoved(account);
  }
}
