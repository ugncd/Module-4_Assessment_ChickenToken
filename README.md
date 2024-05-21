# DegenToken Smart Contract

## Overview

The `DegenToken` is an ERC20 token developed for the Degen Gaming platform on the Avalanche network. This token includes functionalities for minting, transferring, redeeming, checking balances, and burning tokens. It is designed to enhance the gaming experience by enabling in-game transactions and rewards.

## Features

1. **Minting New Tokens**: Only the owner can mint new tokens and distribute them to players as rewards.
2. **Transferring Tokens**: Players can transfer their tokens to others.
3. **Redeeming Tokens**: Players can redeem their tokens for items in the in-game store.
4. **Checking Token Balance**: Players can check their token balance at any time.
5. **Burning Tokens**: Any token holder can burn tokens they own that are no longer needed.

## Contract Details

### Inheritance

- The contract inherits from OpenZeppelin's `ERC20` contract for standard ERC20 functionality.
- The `Ownable` contract is used to restrict certain functions to the contract owner.

### State Variables

- **itemPrices**: A mapping to store the prices of in-game items, with the item ID as the key and the price in tokens as the value.

### Constructor

- **ERC20 Initialization**: Initializes the ERC20 token with the name "Degen" and the symbol "DGN".
- **Initial Minting**: Mints an initial supply of tokens to the owner's address.
- **Item Prices**: Sets predefined prices for specific in-game items.

### Modifiers

- **onlyOwner**: Ensures that certain functions can only be called by the contract owner.

### Functions

- **mint(address account, uint256 amount)**: Allows the owner to mint new tokens and assign them to a specified account.
- **burn(uint256 amount)**: Allows any token holder to burn a specified amount of their tokens.
- **setItemPrice(uint256 itemId, uint256 price)**: Allows the owner to set or update the price of an item.
- **redeemItem(uint256 itemId)**: Allows players to redeem tokens for in-game items, transferring the required amount of tokens from the player to the owner and emitting an `ItemRedeemed` event.

### Events

- **ItemRedeemed(address indexed player, uint256 indexed itemId, uint256 amount)**: Emitted when a player redeems an item using their tokens.

## Usage

### Minting Tokens

Only the owner can mint new tokens. To mint tokens, the owner must call the `mint` function with the recipient's address and the amount of tokens to be minted.

```solidity
mint(address account, uint256 amount)
```

### Transferring Tokens

Players can transfer tokens to other players using the standard `transfer` function from the ERC20 contract.

```solidity
transfer(address recipient, uint256 amount)
```

### Redeeming Tokens

Players can redeem their tokens for items by calling the `redeemItem` function with the item ID.

```solidity
redeemItem(uint256 itemId)
```

### Checking Balance

Players can check their token balance using the `balanceOf` function from the ERC20 contract.

```solidity
balanceOf(address account)
```

### Burning Tokens

Any player can burn their tokens by calling the `burn` function with the amount of tokens to be burned.

```solidity
burn(uint256 amount)
```

## Conclusion

The `DegenToken` smart contract provides a robust token system for the Degen Gaming platform, enabling secure and efficient in-game transactions and rewards. With functionalities for minting, transferring, redeeming, checking balances, and burning tokens, it offers a comprehensive solution for integrating a token economy into the gaming ecosystem. By leveraging OpenZeppelin's ERC20 standard and the `Ownable` contract, the `DegenToken` ensures security, flexibility, and ease of use within the Avalanche network.
