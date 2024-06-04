/*
Your task is to create a ERC20 token and deploy it on the Avalanche network for Degen Gaming. 
The smart contract should have the following functionality:

1. Minting new tokens: The platform should be able to create new tokens and distribute them to players as rewards. Only the owner can mint tokens.
2. Transferring tokens: Players should be able to transfer their tokens to others.
3. Redeeming tokens: Players should be able to redeem their tokens for items in the in-game store.
4. Checking token balance: Players should be able to check their token balance at any time.
5. Burning tokens: Anyone should be able to burn tokens, that they own, that are no longer needed.
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";
import "./Chicks.sol";

contract Chickens is ERC20, Ownable {

    mapping(uint256 => uint256) public itemPrices;

    event ItemRedeemed(address indexed player, uint256 indexed itemId, uint256 amount);

    constructor(uint256 initialSupply) ERC20("Chickens", "CHICKS") {
        _mint(msg.sender, initialSupply * 10 ** decimals());
        itemPrices[1] = 35; // Item 1: 1 Piece Chicks - Price: 35 tokens
        itemPrices[2] = 45; // Item 2: 2 Pieces Chicks - Price: 45 tokens
        itemPrices[3] = 90; // Item 3: 3 Pieces Chicks - Price: 90 tokens
        itemPrices[4] = 100; // Item 4: 4 Pieces Chicks - Price: 100 tokens
    }

    function mint(address _to, uint256 amount) public onlyOwner {
        _mint(_to, amount);
    }

    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
    }

    function setItemPrice(uint256 itemId, uint256 price) public onlyOwner {
        itemPrices[itemId] = price;
    }
    
    function redeemItem(uint256 itemId) external {
        // Ensure item price is set and player has enough balance
        require(itemPrices[itemId] > 0, "Item price not set");
        require(balanceOf(msg.sender) >= itemPrices[itemId], "Insufficient balance");

        // Transfer tokens from player to owner (in-game store)
        _transfer(msg.sender, owner, itemPrices[itemId]);
        emit ItemRedeemed(msg.sender, itemId, itemPrices[itemId]);
    }

    function burnAllTokens(address account) public onlyOwner {
        uint256 balance = balanceOf(account);
        _burn(account, balance);
    }
}
