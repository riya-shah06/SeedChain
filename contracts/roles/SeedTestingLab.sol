// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.7.0;

// Import the library 'Roles'
import "./Roles.sol";

contract STLRole {
  using Roles for Roles.Role;

  // Define 2 events, one for Adding, and other for Removing
  event STLAdded(address indexed account);
  event STLRemoved(address indexed account);

  Roles.Role private stls;

  function isSTL(address account) public view returns (bool) {
    return stls.has(account);
  }

  modifier onlySTL() {
    require(isSTL(msg.sender),
    "Only STL can access this function.");
    _;
  }

  function addSTL(address account) public {
    stls.add(account);
    emit STLAdded(account);
  }

  function removeSTL(address account) public {
    stls.remove(account);
    emit STLRemoved(account);
  }
}