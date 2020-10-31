const supplyChain = artifacts.require("SupplyChain");

module.exports = function (deployer) {
  deployer.deploy(supplyChain);

};