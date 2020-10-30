pragma solidity ^0.5.0;
contract Counter {
  uint public transactionCount = 0;
  
  function AddTransaction() public {
    transactionCount++;
  }
}