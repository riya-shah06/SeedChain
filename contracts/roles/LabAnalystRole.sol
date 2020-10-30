pragma solidity ^0.5.0;

// Import the library 'Roles'
import "./Roles.sol";

// Define a contract 'LabAnalystRole' to manage this role - add, remove, check
contract LabAnalystRole {
  using Roles for Roles.Role;

  // Define 2 events, one for Adding, and other for Removing
  event LabAnalystAdded(address indexed account);
  event LabAnalystRemoved(address indexed account);

  // Define a struct 'labanalysts' by inheriting from 'Roles' library, struct Role
  Roles.Role private labanalysts;

  // Define a function 'isLabAnalyst' to check this role
  function isLabAnalyst(address account) public view returns (bool) {
    return labanalysts.has(account);
  }

  // Define a function 'addLabAnalyst' that adds this role
  function addLabAnalyst(address account) public {
    _addLabAnalyst(account);
  }

  // Define a function 'renounceLabAnalyst' to renounce this role
  function renounceLabAnalyst() public {
    _renounceLabAnalyst(msg.sender);
  }
  
  // Define a function '_renounceLabAnalyst' to explicitly renounce this role
  function _renounceLabAnalyst(address account) internal {
      _removeLabAnalyst(account);
  }

  // Define an internal function '_addLabAnalyst' to add this role, called by 'addLabAnalyst'
  function _addLabAnalyst(address account) internal {
    labanalysts.add(account);
    emit LabAnalystAdded(account);
  }

  // Define an internal function '_removeLabAnalyst' to remove this role, called by '_renounceLabAnalyst'
  function _removeLabAnalyst(address account) internal {
    labanalysts.remove(account);
    emit LabAnalystRemoved(account);
  }
}
