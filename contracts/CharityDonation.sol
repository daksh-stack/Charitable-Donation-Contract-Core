// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract CharityDonation {
    address public owner;
    uint256 public totalDonations;

    mapping(address => uint256) public donorBalances;

    event DonationMade(address indexed donor, uint256 amount);
    event Withdrawal(address indexed to, uint256 amount);

    constructor() {
        owner = msg.sender;
    }

    // Donate to charity
    function donate() external payable {
        require(msg.value > 0, "Donation must be greater than 0");
        totalDonations += msg.value;
        donorBalances[msg.sender] += msg.value;

        emit DonationMade(msg.sender, msg.value);
    }

    // Withdraw funds (only the owner)
    function withdraw(uint256 amount) external {
        require(msg.sender == owner, "Only the owner can withdraw");
        require(amount <= address(this).balance, "Insufficient funds");

        payable(owner).transfer(amount);
        emit Withdrawal(owner, amount);
    }

    // Get the balance of the contract
    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }

    // Get donation details of a specific donor
    function getDonationDetails(address donor) external view returns (uint256) {
        return donorBalances[donor];
    }
}
