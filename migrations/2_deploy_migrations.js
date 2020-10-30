const Counter = artifacts.require("./Counter.sol"); //change filename here to own contract

module.exports = function (deployer) {
    deployer.deploy(Counter);
};