import { ethers } from "hardhat";

async function main() {
  const glp = await ethers.deployContract("Token", ["GLP Token", "GLP"]);

  await glp.waitForDeployment();

  console.log(`GLP token deployed at ${glp.target}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
