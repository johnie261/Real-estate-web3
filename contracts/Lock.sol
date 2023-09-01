// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract ChatApp {
    
    struct user {
        string name;
        friend[] friendList;
    }

    struct friend {
        address pubkay;
        string name;
    }

    struct message {
        address sender;
        uint256 timestamp;
        string msg;
    }

    mapping(address => user) userList;
    mapping(bytes23 => message[]) allMessages;

    function checkUserExists(address pubkey) public view returns(bool) {
        return bytes(userList[pubkey].name).length > 0;
    }

    function createAccount(string calldata name) external {
        require(checkUserExists(msg.sender) == false, "User already exists");
        require(bytes(name).length > 0, "Username cannot be empty");

        userList[msg.sender].name = name;
    }

    function getUsername(address pubkey) external view returns (string memory) {
        require(checkUserExists(pubkey), "User is not registered")
        return userList[pubkey].name;
    }
}
