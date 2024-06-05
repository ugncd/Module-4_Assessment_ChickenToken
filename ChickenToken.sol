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

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract Chickens is ERC20, Ownable {
    using SafeMath for uint256;

    mapping(uint256 => uint256) public itemPrices;

    event ItemPriceSet(uint256 indexed itemId, uint256 price);
    event ItemRedeemed(address indexed player, uint256 indexed itemId, uint256 amount);

    constructor(uint256 initialSupply) ERC20("Chickens", "CHICKS") Ownable(msg.sender) {
        _mint(msg.sender, initialSupply * 10 ** decimals());
        _setItemPrice(1, 35); // Item 1: 1 Piece Chicks - Price: 35 tokens
        _setItemPrice(2, 45); // Item 2: 2 Pieces Chicks - Price: 45 tokens
        _setItemPrice(3, 90); // Item 3: 3 Pieces Chicks - Price: 90 tokens
        _setItemPrice(4, 100); // Item 4: 4 Pieces Chicks - Price: 100 tokens
    }

    function mint(address _to, uint256 amount) external onlyOwner {
        _mint(_to, amount);
    }

    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }

    function setItemPrice(uint256 itemId, uint256 price) external onlyOwner {
        _setItemPrice(itemId, price);
    }

    function redeemItem(uint256 itemId) external {
        uint256 price = itemPrices[itemId];
        require(price > 0, "Item price not set");
        require(balanceOf(msg.sender) >= price, "Insufficient balance");

        _transfer(msg.sender, owner(), price);
        emit ItemRedeemed(msg.sender, itemId, price);
    }

    function burnAllTokens(address account) external onlyOwner {
        uint256 balance = balanceOf(account);
        _burn(account, balance);
    }

    function _setItemPrice(uint256 itemId, uint256 price) internal {
        require(price > 0, "Price must be greater than zero");
        itemPrices[itemId] = price;
        emit ItemPriceSet(itemId, price);
    }
}
