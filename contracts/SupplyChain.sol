// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.7.0;


//importing all roles

import "./roles/FarmerRole.sol";
import "./roles/SeedCertificationAgency.sol";
import "./roles/SeedProducingAgency.sol";
import "./roles/SeedProducingPlant.sol";
import "./roles/SeedTestingLab.sol";

contract SupplyChain is FarmerRole, SCARole, SPARole, SPPRole, STLRole {
    
    address owner;
    uint[] arrOfAppIds;
    
    enum State {
        
        Applied,     //0
        Verification,    //1
        Inspection,   //2
        AssignSPP,    //3
        SeedProcessing,    //4
        SampleTest,  //5
        Certification,   //6
        Granted,      //7
        Sold,        //8
        Returned     //9
    }

    uint private numOfStates = 10;

    struct SPA {
        uint appid;
        string lotNumber;
        string owner;
        string crop;
        string variety;
        string sourceTagNo;
        string sourceClass;
        string destinationClass;
        string sourceQuantity;
        uint sourceDateOfIssue;
        string growerName;
        string spaName;
        uint dateOfIssue;
        string sourceStoreHouse;
        string destiStoreHouse;
        string sgName;
        string sgId;
        string finYear;
        string season;
        uint landRecordsKhataNo;
        uint landRecordsPlotNo;
        string landRecordsArea;
        string cropRegCode;
        string sppName; 
        string sppId;
        string totalQuantityProcessed;
        uint processingDate;
        uint verificationDate;
        string sampleSecreteCode;
        bool samplePassed;
        uint sampleTestDate;
        string certificateNo;
        uint certificateDate;
        string tagSeries;
        string tagIssuedRangeFrom;
        string tagIssuedRangeTo;
        string[] tags;
        uint noOfTagsIssued;
        uint certificateValidity;
        uint lastBagSold;
        address[] farmersSoldTo;
    }
    
    event ApplicationReceived(uint appid);
    event VerificationStageReached(uint appid);
    event InspectionStageReached(uint appid);
    event WaitingToAssignSPP(uint appid);
    event SeedProcessingStageReached(uint appid);
    event SampleTestStageReached(uint appid);
    event CertificateStageReached(uint appid);
    event CertificateGranted(uint appid);
    
    State constant defaultState = State.Applied;
    mapping (uint => State) mapState; 
    mapping (uint => SPA) spaOfId;
    mapping (string=>SPA) secreteCodetoSPA;

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

    // function to generate empty AppId if required
    function generateEmptyApplication(uint appid) external onlySPA{
        arrOfAppIds.push(appid);
        mapState[appid] = defaultState;
        SPA memory spa;
        spaOfId[appid] = spa;

        emit ApplicationReceived(appid);
    }

    // function to generate appln id and map to its first default state
    function generateApplicationPart1(uint appid,
        string calldata lotNumber,
        string calldata Spaowner,
        string calldata crop,
        string calldata variety,
        string calldata sourceTagNo
    ) external onlySPA {
        arrOfAppIds.push(appid);

        mapState[appid] = State.Verification;
        SPA storage spa;
        spa.appid = appid;
        spa.lotNumber = lotNumber;
        spa.owner = Spaowner;
        spa.crop = crop;
        spa.variety = variety;
        spa.sourceTagNo = sourceTagNo;

        spaOfId[appid] = spa;

    }

    function generateApplicationPart2(uint appid,
        string memory sourceClass,
        string memory destinationClass,
        string memory sourceQuantity,
        uint sourceDateOfIssue,
        string memory growerName,
        string memory spaName,
        uint dateOfIssue
    ) external onlySPA {
        SPA storage spa = spaOfId[appid];

        spa.sourceClass = sourceClass;
        spa.destinationClass = destinationClass;
        spa.sourceQuantity = sourceQuantity;
        spa.sourceDateOfIssue = sourceDateOfIssue;
        spa.growerName = growerName;
        spa.spaName = spaName;
        spa.dateOfIssue = dateOfIssue;

        spaOfId[appid] = spa;
    }

    function generateApplicationPart3(uint appid,
        string memory sourceStoreHouse,
        string memory destiStoreHouse,
        string memory sgName,
        string memory sgId,
        string memory finYear,
        string memory season,
        uint landRecordsKhataNo,
        uint landRecordsPlotNo,
        string memory landRecordsArea,
        string memory cropRegCode
    ) external onlySPA {
        SPA storage spa = spaOfId[appid];

        spa.sourceStoreHouse = sourceStoreHouse;
        spa.destiStoreHouse = destiStoreHouse;
        spa.sgName = sgName;
        spa.sgId = sgId;
        spa.finYear = finYear;
        spa.season = season;
        spa.landRecordsKhataNo = landRecordsKhataNo;
        spa.landRecordsPlotNo = landRecordsPlotNo;
        spa.landRecordsArea = landRecordsArea;
        spa.cropRegCode = cropRegCode;

        spaOfId[appid] = spa;
        
        emit VerificationStageReached(appid);

    }

    function verifySPAData(uint appid) external onlySCA {
        mapState[appid] = State.Inspection;

        emit InspectionStageReached(appid);
    }

    function inspectData(uint appid) external onlySCA {
        mapState[appid] = State.AssignSPP;

        emit WaitingToAssignSPP(appid);
    }
 

    function assignSPP(uint appid,
        string calldata sppName,
        string calldata sppId
    ) external onlySCA {

        mapState[appid] = State.SeedProcessing;
        SPA storage spa = spaOfId[appid];

        spa.sppName = sppName;
        spa.sppId = sppId;

        spaOfId[appid] = spa;

        emit SeedProcessingStageReached(appid);
    }

    function uploadSeedProcessingResults(uint appid,
        string calldata totalQuant,
        uint processingDate,
        uint verificationDate,
        string calldata sampleSecreteCode
    ) external onlySCA {

        mapState[appid] = State.SampleTest;
        SPA storage spa = spaOfId[appid];

        spa.totalQuantityProcessed = totalQuant;
        spa.processingDate = processingDate;
        spa.verificationDate = verificationDate;
        spa.sampleSecreteCode = sampleSecreteCode;

        spaOfId[appid] = spa;
        secreteCodetoSPA[sampleSecreteCode] = spa;

        emit SampleTestStageReached(appid);
    }

    function uploadSampleTestResults(string calldata sampleSecreteCode,
        bool samplePassed,
        uint sampleTestDate
    ) external onlySTL {

        SPA storage spa = secreteCodetoSPA[sampleSecreteCode];
        uint appid = spa.appid;
        mapState[appid] = State.Certification;

        spa.samplePassed = samplePassed;
        spa.sampleTestDate = sampleTestDate;

        secreteCodetoSPA[sampleSecreteCode] = spa;
        spaOfId[appid] = spa;

        emit CertificateStageReached(appid);
    }

    function grantCertificate(uint appid,
        string memory certificateNo,
        uint certificateDate,
        string memory tagSeries,
        string calldata tagRangeFrom,
        uint tagNumberStart,
        string calldata tagRangeTo,
        uint noOfTags,
        uint certiValidity
    ) external onlySCA {

        mapState[appid] = State.Granted;
        SPA storage spa = spaOfId[appid];

        spa.certificateNo = certificateNo;
        spa.certificateDate = certificateDate;
        spa.tagSeries = tagSeries;
        spa.tagIssuedRangeFrom = tagRangeFrom;
        spa.tagIssuedRangeTo = tagRangeTo;
        spa.noOfTagsIssued = noOfTags;
        spa.certificateValidity = certiValidity;
        spa.lastBagSold = 0;

        // this loop creates and stores all tags of the bags for farmer to buy from
        for(uint i=0; i<noOfTags; i++){
            
            string memory tagno = string(abi.encodePacked(tagSeries, (tagNumberStart+i)));
            spa.tags.push(tagno);
        }

        spaOfId[appid] = spa;
        secreteCodetoSPA[spa.sampleSecreteCode] = spa;

        uint i=0;
        while(i < arrOfAppIds.length){
            if(arrOfAppIds[i] == appid){
                break;
            }
        }
        arrOfAppIds[i] = arrOfAppIds[arrOfAppIds.length - 1];
        arrOfAppIds.pop();

        emit CertificateGranted(appid);
    }

    function sellBagsToFarmer(uint appid, address farmer, uint noOfBags) external returns (string memory TagStartFrom) {
        SPA storage spa = spaOfId[appid];
        if(spa.lastBagSold == 0){
            TagStartFrom = spa.tagIssuedRangeFrom;
        }
        else {
            // add TagStartFrom based on what is generated
        }
        spa.lastBagSold += noOfBags;

        // here will have to check if this farmer already exists in array, If yes, then skip
        spa.farmersSoldTo.push(farmer);
        spaOfId[appid] = spa;
        secreteCodetoSPA[spa.sampleSecreteCode] = spa;
    }

}
