const Migrations = artifacts.require("SupplyChain");
const Farmer = artifacts.require("roles/FarmerRole");
const Roles = artifacts.require("roles/Roles");


module.exports = function (deployer) {
  deployer.deploy(Migrations);
  deployer.deploy(Roles);
  deployer.deploy(Farmer);
};