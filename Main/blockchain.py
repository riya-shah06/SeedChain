from web3 import Web3
import json
import hashlib
import datetime
import _sha3

curr_appid_number = 1

ganache_url = "http://127.0.0.1:8545"
web3 = Web3(Web3.HTTPProvider(ganache_url))

#to check connection
print("Connected to Ganache Server: ", web3.isConnected())

supplyChainContractAddress = web3.toChecksumAddress("")
supplyChainContractAbi = json.loads("")
supplyChainContract = web3.eth.contract(address=supplyChainContractAddress, abi=supplyChainContractAbi)

SCAContractAddress = web3.toChecksumAddress("")
SCAContractAbi = json.loads("")
SCAContract = web3.eth.contract(address=SCAContractAddress, abi=SCAContractAbi)

SPAContractAddress = web3.toChecksumAddress("")
SPAContractAbi = json.loads("")
SPAContract = web3.eth.contract(address=SPAContractAddress, abi=SPAContractAbi)

SPPContractAddress = web3.toChecksumAddress("")
SPPContractAbi = json.loads("")
SPPContract = web3.eth.contract(address=SPPContractAddress, abi=SPPContractAbi)

STLContractAddress = web3.toChecksumAddress("")
STLContractAbi = json.loads("")
STLContract = web3.eth.contract(address=STLContractAddress, abi=STLContractAbi)

FarmerContractAddress = web3.toChecksumAddress("")
FarmerContractAbi = json.loads("")
FarmerContract = web3.eth.contract(address=FarmerContractAddress, abi=FarmerContractAbi)

def hash(fname, lname, phone_number):
    return hashlib.sha256(bytes(fname.lower() + lname.lower() + str(phone_number)))

def hash(name, id):
    return hashlib.sha256(bytes(name.lower() + str(id)))

def generate_app_id():
    global curr_appid_number
    f = open('Main/appids.txt', 'r')
    out = open('Main/appids.txt', 'w')
    lines = f.read().splitlines()
    if(len(lines) > 1):
        prev_app_id = lines[-1]
    else:
        prev_app_id = ""
    dt = datetime.datetime.now()
    curr_date = int(dt.strftime("%Y%m%d%H%M"))
    if(prev_app_id==""):
        app_id = str(curr_date) + str(curr_appid_number)
        curr_appid_number+=1
    else:
        prev_date = prev_app_id[:12]
        if(prev_date==curr_date):
            app_id = str(curr_date) + str(curr_appid_number)
            curr_appid_number+=1
        else:
            curr_appid_number = 1
            app_id = str(curr_date) + str(curr_appid_number)
        curr_appid_number += 1
    out.write(app_id)
    return int(app_id)


def bc_create_profile(role, fname, lname, phone_number):
    ## address - hash of fname+lname+phone_number
    role = role.lower()
    address = hash(fname, lname, phone_number)
    if role == 'farmer':
        FarmerContract.functions.addFarmer(address)
    elif role == 'spa':
        SPAContract.functions.addSPA(address)
        # dummy sg names and ids
        sg_list = [{'name': 'Ram Babu', 'id':'1234'}, {'name': 'Anand Singh', 'id':'4512'}, {'name': 'Kabir Singh', 'id':'5166'}]
        for elem in sg_list:
            # calling contract functiont to add sg
            sg_address = hash(elem['name'], elem['id'])
            SPAContract.functions.addSG(address, elem['name'], str(elem['id']))
    elif role =='spp':
        SPPContractAddress.functions.addSPP(address)
    elif role == 'sca':
        SCAContractAddress.functions.addSCA(address)
    elif role == 'stl':
        STLContractAddress.functions.addSTL(address)


def buy_seeds(app_id, quantity, fname, lname, phone_no):
    farmerAddress = hash(fname, lname, phone_no)
    supplyChainContractAddress.functions.sellBagsToFarmer(app_id, farmerAddress, quantity)

def generate_application(args_list):
    dt = datetime.datetime.now()
    date_of_issue = int(dt.strftime("%Y%m%d%H%M"))
    print(date_of_issue)
    lotNumber = args_list['lotNumber']
    owner = args_list['owner']
    crop = args_list['crop']
    variety = args_list['variety']
    sourceTagNo = args_list['sourceTagNo']
    sourceClass = args_list['sourceClass']
    destinationClass = args_list['destinationClass']
    sourceQuantity = args_list['sourceQuantity']
    growerName = args_list['growerName']
    spaName = args_list['spaName']
    sourceStorehouse = args_list['sourceStorehouse']
    sgID = args_list['sgID']
    finYear = args_list['finYear']
    season =args_list['season']
    landRecordsKhataNo = args_list['landRecordsKhataNo']
    landRecordsPlotNo = args_list['landRecordsPlotNo']
    landRecordsArea = args_list['landRecordsArea']
    cropRegCode = args_list['cropRegCode']
    ##change later
    destiStoreHouse = ""

    app_id = generate_app_id()

    supplyChainContract.functions.generateApplicationPart1(app_id,lotNumber, owner, crop, variety, sourceTagNo)
    supplyChainContract.functions.generateApplicationPart2(app_id,sourceClass, destinationClass, sourceQuantity, date_of_issue, growerName, spaName)
    supplyChainContract.functions.generateApplicationPart3(app_id,sourceStorehouse, destiStoreHouse, sgID, finYear, season, int(landRecordsKhataNo), int(landRecordsPlotNo), landRecordsArea, cropRegCode)
    print("Generating Application")