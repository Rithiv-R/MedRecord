const Medicallist = artifacts.require("Medicallist");

module.exports = function(deployer)
{
    deployer.deploy(Medicallist);  
}