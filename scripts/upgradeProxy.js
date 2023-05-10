const { ethers, upgrades  } = require("hardhat");

const proxyAddress = '0x658FB78937285C2bDC0Ab097Bb1d5d3cbEcCbf14'

async function main() {
    const VendingMachineV3 = await ethers.getContractFactory('VendingMachineV3');
    const upgraded = await upgrades.upgradeProxy(proxyAddress, VendingMachineV3);
    await upgraded.deployed();

    const implementationAddress = await upgrades.erc1967.getImplementationAddress(proxyAddress);

    console.log('The current contract owner is: ' + upgraded.owner());
    console.log('Implementation contract address: ' + implementationAddress);
}

main();
