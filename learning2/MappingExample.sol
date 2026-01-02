// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract MappingExample {
    mapping(address account => uint256 bdata) public balances;
    function setBalance(uint256 amount) public {
        balances[msg.sender] = amount;
    }
    function getBalance(address user) public view returns (uint256) {
        return balances[user];
    }

    mapping(address => mapping(string => uint256)) public userBalances;
    function setUserBalance(string memory currency, uint256 amount) public {
        userBalances[msg.sender][currency] = amount;
    }
    function getUserBalance(
        address user,
        string memory currency
    ) public view returns (uint256) {
        return userBalances[user][currency];
    }
}
