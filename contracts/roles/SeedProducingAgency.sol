// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.7.0;

import "./Roles.sol";

// Define a contract 'SPARole' to manage this role - add, remove, check
contract SPARole {
    using Roles for Roles.Role;

    // define a struct seedGrower that grows seeds
    struct seedGrower {
        address nodeAddress;
        string sgName;
        string sgId;
    }

    mapping(address => seedGrower[]) sgList;
    mapping(address => seedGrower) sgAccount;

    // Define 2 events, one for Adding, and other for Removing
  event SPAAdded(address indexed account);
  event SPARemoved(address indexed account);
  // Define 2 events, one for Adding, and other for Removing
  event SGAdded(address indexed account);
  event SGRemoved(address indexed account);

  // define a struct 'spas' by inheriting it from Roles.Role
  Roles.Role private spas;

  // define a modifier to be used for adding/removing SGs
  modifier onlySPA {
      require(isSPA(msg.sender),
      "Only SPAs can perform this function"
      );
      _;
  }

  // define a function isSPA to check this role
  function isSPA(address account) public view returns (bool) {
      return spas.has(account);
  }

  // define a function addSPA and remove SPA to add/remove roles
  function addSPA(address account) public {
      spas.add(account);
      emit SPAAdded(account);
  }

  function removeSPA(address account) public {
      spas.remove(account);
      emit SPARemoved(account);
  }

  function addSG(address account, string memory name, string memory id) public onlySPA {
      seedGrower memory sg = seedGrower(account, name, id);
      sgList[msg.sender].push(sg);
      sgAccount[account] = sg;

      emit SGAdded(account);
  }

  function removeSG(address account) public onlySPA {
      seedGrower memory sg = sgAccount[account];

      seedGrower[] storage sgArr = sgList[msg.sender];
      uint i=0;
      while(i < sgArr.length) {
          if(sgArr[i].nodeAddress == sg.nodeAddress){
              break;
          }
      }
      sgArr[i] = sgArr[sgArr.length - 1];
      sgArr.pop();

      sgList[msg.sender] = sgArr;
  }
}