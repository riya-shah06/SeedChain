pragma solidity ^0.5.0;


contract UserRegistry {
  address public owner = msg.sender;

  mapping(address=>address) registry;

modifier onlyBy(address _account)
    {
        require(msg.sender == _account);
        _;
    }

  function setInspector (address memory applicant, address memory inspector) public onlyBy(owner) {
    registry[applicant] = inspector;
  }

  function getInspector (address memory applicant) public view returns(string memory) {
    return registry[applicant];
  }
  
}
