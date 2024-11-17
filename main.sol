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
