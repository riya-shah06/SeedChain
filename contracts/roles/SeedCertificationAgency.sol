// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.7.0;

// Import the library 'Roles'
import "./Roles.sol";

contract SCARole {
  using Roles for Roles.Role;

  // Define 2 events, one for Adding, and other for Removing
  event SCAAdded(address indexed account);
  event SCARemoved(address indexed account);

  // Define a struct 'scas' by inheriting from 'Roles' library, struct Role
  Roles.Role private scas;

  modifier onlySCA() {
    require(isSCA(msg.sender),
    "Only SCAs can access this function.");
    _;
  }

  function isSCA(address account) public view returns (bool) {
    return scas.has(account);
  }

  function addSCA(address account) public {
    scas.add(account);
    emit SCAAdded(account);
  }

  function removeSCA(address account) public {
    scas.remove(account);
    emit SCARemoved(account);
  }
}
