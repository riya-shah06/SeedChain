// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.7.0;


//importing all roles

import "./FarmerRole.sol";
import "./SeedCertificationAgency.sol";
import "./SeedProducingAgency.sol";
import "./SeedProducingPlant.sol";
import "./SeedTestingLab.sol";

contract SupplyChain {
    
    address owner;
    
    enum State {
        
        Applied,     //0
        Inspect1,    //1
        Harvested,   //2
        Inspect2,    //3
        Packaged,    //4
        SampleTest,  //5
        Granted,     //6
        Rejected     //7
    }
    
    event ApplicationReceived(uint appid);
    event Inspection1Complete(uint appid);
    event Harvested(uint appid);
    event Inspection2Complete(uint appid);
    event Packaged(uint appid);
    event SampleTestConducted(uint appid);
    event CertificateGranted(uint appid);
    event ApplicationRejected(uint appid);
    
    State constant defaultState = State.Applied;
    mapping (uint => State) mapState;
    uint appid = 0;
    if(currentState==State.Applied) {
        appid++;
        currentState = State.Inspect1;
        emit ApplicationReceived(appid);
    }


    // helper hash function - 1 param
    function hash(string memory _str) private pure returns(bytes32) {
        return  keccak256(abi.encode(_str));
    }
    // helper hash function - 2 params
    function hash(string memory _str1, string memory _str2) private pure returns(bytes32) {
        return  keccak256(abi.encode(_str1, _str2));
    }
    
    modifier onlyOwner(){
        require(isOwner(),
        "You are not the owner");
        _;
    }
    
    //Check if calling address is of the owner
    function isOwner() public view returns (bool) {
        return (msg.sender == owner);
    }
    
    // Define a modifer that verifies the Caller
    modifier verifyCaller(address _address) {
    require(msg.sender == _address,
    "Not the right caller");
    _;
    }




}
