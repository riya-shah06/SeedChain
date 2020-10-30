from web3 import Web3
import json

ganache_url = "http://127.0.0.1:8545"
w3 = Web3(Web3.HTTPProvider(ganache_url))

# to check connection
print(w3.isConnected())

contract_abi = json.loads('[{"constant": true, "inputs": [], "name": "trasactionCount", "outputs": [{"name": "",'
                         '"type": "uint256"}],"payable": false,"stateMutability": "view","type": "function",'
                         '"signature": "0xe019d077"},{"constant": false,"inputs": [],"name": "AddTransaction",'
                         '"outputs": [],"payable": false,"stateMutability": "nonpayable","type": "function",'
                         '"signature": "0xd8a6e767"}]')
print("done")
contract_address = w3.toChecksumAddress("0x1D55c51DcB1cB5E817C8612A8ef2907707D72Bed")

contract = w3.eth.contract(address=contract_address, abi=contract_abi)
print(contract.functions.AddTransaction().call())  # just an example
