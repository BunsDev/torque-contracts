import { ethers } from "hardhat";

async function main() {
  const usdc = await ethers.deployContract("Token", ["USDC Token", "USDC"]);

  await usdc.waitForDeployment();

  console.log(`USDC token deployed at ${usdc.target}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
