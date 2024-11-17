# Metacrafter-AVAX-1

This Solidity code demonstrates an example use for the require, assert, and reverse function using a Music Store. The Music Store works by only allowing subscribers to purchase an album; which if they aren't must pay for the subscription.

## Description

The code is written in Solidity, a programming language for developing in Ethereum. The contract contains functions for minting, as well as burning tokens. The program serves as a good introduction to Solidity programming, through the use of require, assert, and reverse functions.

### Executing program
The code can be run using Remix, an online Solidity IDE. Remix can be accessed and used in https://remix.ethereum.org/.

Once you are on the Remix website, create a new file by clicking on the "+" icon in the left-hand sidebar. Save the file with a .sol extension. Copy and paste the code into the editor:
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract MusicStore {
    // Public variables
    mapping(address => bool) private subscribers;
    uint public albumPrice = 5 wei;
    uint public albumStock = 50;
    uint public albumSold;
    mapping(address => uint256) private purchases;

    // Modifier to restrict access to subscribers
    modifier subscriberOnly() {
        require(subscribers[msg.sender], "You must be a subscriber to purchase this album.");
        _;
    }

    // Subscribe function
    function subscribe() public payable {
        require(msg.value == 1 wei, "Pay 1 wei to become a subscriber");
        require(!subscribers[msg.sender], "Already subscribed");
        subscribers[msg.sender] = true;
    }

    // Purchase function restricted to subscribers
    function purchase() public payable subscriberOnly {
        require(msg.value == albumPrice, "Incorrect amount paid for the album");
        require(albumSold < albumStock, "Album out of stock");

        if (purchases[msg.sender] >= 2) {
            revert("You have reached the maximum purchase limit of 2 albums.");
        }

        purchases[msg.sender]++;
        albumSold++;
        albumStock--; // Reduce stock on successful purchase

        assert(albumSold <= 50); // Ensure total sold is within the original stock
    }

    // Check if an address is a subscriber
    function isSubscriber(address _address) public view returns (bool) {
        return subscribers[_address];
    }

    // Check purchases of a subscriber
    function getPurchases(address _subscriber) public view returns (uint256) {
        return purchases[_subscriber];
    }
}
```

To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.18", and then click on the "Compile" button.

Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar. Select the "MusicStore" contract from the dropdown menu, and then click on the "Deploy" button.

Once the contract is deployed, you can interact with it by calling the purchase, subscribe, and other functions in the contract. To use the purchase and subscribe functions, you must select Wei as the currency and then enter value before using the said functions. Additionally, you can use the getPurchases and isSubscriber functions to check an account's purchase as well as if it is a subscriber using their addresses.

## Authors
TWENTY-2020

## License
This project is licensed under the MIT License - see the LICENSE.md file for details


