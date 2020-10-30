pragma solidity ^0.5.0;

import "./../roles/FarmerRole.sol";
import "./../roles/InspectorRole.sol";
import "./../roles/LabAnalystRole.sol";

contract SupplyChain is FarmerRole, InspectorRole, LabAnalystRole {
    
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
    
    constructor() public {
        owner = msg.sender;
    }
    
       
    
    
}
