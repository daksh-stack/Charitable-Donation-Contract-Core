const hre = require("hardhat");

async function main() {
  const [deployer] = await hre.ethers.getSigners();
  console.log("Deploying CharityDonation contract from:", deployer.address);

  const CharityDonation = await hre.ethers.getContractFactory("CharityDonation");
  const charityDonation = await CharityDonation.deploy();
  await charityDonation.waitForDeployment(); // ✅ Updated

  console.log("✅ CharityDonation contract deployed at:", charityDonation.target); // for ethers v6
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
