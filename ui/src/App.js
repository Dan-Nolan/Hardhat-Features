import { ethers } from 'ethers';
import CoinFlip from "./artifacts/contracts/CoinFlip.sol/CoinFlip.json";
import './App.css';

const ethereum = window.ethereum;

function App() {
  async function makeWager() {
    await ethereum.request({ method: 'eth_requestAccounts' });

    const provider = new ethers.providers.Web3Provider(ethereum);

    console.log("HEY!");

    console.log(await provider.listAccounts());

    const signer = await provider.getSigner(0);

    const contract = new ethers.Contract(process.env.REACT_APP_COINFLIP_CONTRACT, CoinFlip.abi, signer);

    await contract.wager({
      value: ethers.utils.parseEther("0.5")
    });
  }

  return (
    <div className="App">
      <div className="button" onClick={makeWager}>
        MAKE WAGER
      </div>
    </div>
  );
}

export default App;
