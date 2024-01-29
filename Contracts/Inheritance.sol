// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Ownable {
     address owner;

    constructor() {
        owner = msg.sender;
    }

    modifier isOwner{
        require(msg.sender == owner, "Restricted to contract owner.");
        _;
    }
}

contract SecretVault {
     string secret;

    constructor(string memory _secret) {
        secret = _secret;
    }

    function getSecret() public view returns(string memory) {
        return secret;
    }
}

contract MyContract is Ownable{

    address vaultAddress;

    constructor(string memory _secret) {
        SecretVault _vault = new SecretVault(_secret);
        vaultAddress = address(_vault);
        super;
    }

    function getSecret() public isOwner view returns(string memory) {
        return SecretVault(vaultAddress).getSecret();
    }
}