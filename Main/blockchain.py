from web3 import Web3
import json

ganache_url = "http://127.0.0.1:8545"
w3 = Web3(Web3.HTTPProvider(ganache_url))

#to check connection
print(w3.isConnected())

contract_address = web3.toChecksumAddress("")
contract_abi = json.loads("")

contract = web3.eth.contract(address=contract_address, abi=contract_abi)
print(contract.functions.getInspector().call()) #just an example
