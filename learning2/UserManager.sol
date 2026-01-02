// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract UserManager {
    struct User {
        string name;
        uint256 age;
        address wallet;
    }

    struct Person {
        string name;
        uint256 age;
        Hobbie[] hobbies;
    }

    struct Hobbie {
        string label;
        string value;
    }

    mapping(address => User) public users;
    function setUser(string memory name, uint256 age) public {
        users[msg.sender] = User(name, age, msg.sender);
    }
    function getUser(
        address userAddress
    ) public view returns (string memory, uint256, address) {
        User memory user = users[userAddress];
        return (user.name, user.age, user.wallet);
    }

    Person[] public persons;
    mapping(address => Person) public personMap;

    function addPerson(Person calldata p) public {
        persons.push(p);
    }

    function addPersonMap(Person calldata p, address addr) public {
        personMap[addr] = p;
    }
}
