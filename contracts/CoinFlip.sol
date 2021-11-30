//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract CoinFlip {
    address owner;
    
    constructor() payable {
        owner = msg.sender;
    }

    receive() external payable {
        // owner to refill this contract
        require(msg.sender == owner);
    }

    function withdraw() external {
        require(msg.sender == owner);
        payable(owner).transfer(address(this).balance);
    }

    function wager() external payable {
        uint wagerAmount = msg.value;
        uint availableBalance = address(this).balance - msg.value;
        require(wagerAmount <= availableBalance, "not enough funds");

        bytes32 blockHash = blockhash(block.number - 1);
        bool isEven = (uint(blockHash) % 2) == 0;

        if(isEven) {
            (bool success, ) = payable(msg.sender).call{ value: msg.value * 2 }("");
            require(success);
        }
    }
}
