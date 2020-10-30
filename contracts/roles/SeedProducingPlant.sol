// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.7.0;

// Import the library 'Roles'
import "./Roles.sol";

contract SPPRole {
  using Roles for Roles.Role;

  // Define 2 events, one for Adding, and other for Removing
  event SPPAdded(address indexed account);
  event SPPRemoved(address indexed account);

  Roles.Role private spps;

  function isSPP(address account) public view returns (bool) {
    return spps.has(account);
  }

  modifier onlySPP() {
    require(isSPP(msg.sender),
    "Only SPP can access this function.");
    _;
  }

  function addSPP(address account) public {
    spps.add(account);
    emit SPPAdded(account);
  }

  function removeSPP(address account) public {
    spps.remove(account);
    emit SPPRemoved(account);
  }
}
