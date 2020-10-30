pragma solidity ^0.5.0;


contract UserRegistry {
  address public owner = msg.sender;

  mapping(address=>address) farmer2inspector;
  mapping(address=>address) farmer2lab;
  mapping(address=>address[]) public inspector2farmers;
  mapping(address=>address[]) public lab2farmers;

    modifier onlyBy(address _account)
    {
        require(msg.sender == _account);
        _;
    }

  function setInspector (address applicant, address inspector) public onlyBy(owner) {
    farmer2inspector[applicant] = inspector;
    inspector2farmers[inspector].push(applicant);
  }
  
  function setLabAnalyst(address applicant, address lab) public onlyBy(owner) {
      farmer2lab[applicant] = lab;
      lab2farmers[lab].push(applicant);
  }

  function getInspector (address applicant) public view returns(address) {
    return farmer2inspector[applicant];
  }
  
  function getLabAnalyst(address applicant) public view returns(address) {
      return farmer2lab[applicant];
  }
  
  
}
