pragma solidity ^0.5.0;

// Import the library 'Roles'
import "./Roles.sol";

// Define a contract 'InspectorRole' to manage this role - add, remove, check
contract InspectorRole {
  using Roles for Roles.Role;

  // Define 2 events, one for Adding, and other for Removing
  event InspectorAdded(address indexed account);
  event InspectorRemoved(address indexed account);

  // Define a struct 'inspectors' by inheriting from 'Roles' library, struct Role
  Roles.Role private inspectors;

  // Define a function 'isInspector' to check this role
  function isInspector(address account) public view returns (bool) {
    return inspectors.has(account);
  }

  // Define a function 'addInspector' that adds this role
  function addInspector(address account) public {
    _addInspector(account);
  }

  // Define a function 'renounceInspector' to renounce this role
  function renounceInspector() public {
    _renounceInspector(msg.sender);
  }
  
  // Define a function '_renounceInspector' to explicitly renounce this role
  function _renounceInspector(address account) internal {
      _removeInspector(account);
  }

  // Define an internal function '_addInspector' to add this role, called by 'addInspector'
  function _addInspector(address account) internal {
    inspectors.add(account);
    emit InspectorAdded(account);
  }

  // Define an internal function '_removeInspector' to remove this role, called by '_renounceInspector'
  function _removeInspector(address account) internal {
    inspectors.remove(account);
    emit InspectorRemoved(account);
  }
}
