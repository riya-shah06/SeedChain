pragma solidity 0.5.16;
contract Counter {
  uint public trasactionCount = 0;
  
  function AddTransaction() public {
    trasactionCount++;
  }
}