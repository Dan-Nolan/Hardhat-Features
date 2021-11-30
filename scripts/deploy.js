const hre = require("hardhat");

async function main() {
  const CoinFlip = await hre.ethers.getContractFactory("CoinFlip");
  const coinflip = await CoinFlip.deploy({
    value: ethers.utils.parseEther("0.5")
  });
  await coinflip.deployed();

  console.log("CoinFlip deployed to:", coinflip.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
