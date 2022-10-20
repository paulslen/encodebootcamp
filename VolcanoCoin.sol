// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

contract VolcanoCoin {

    uint256 totalSupply = 10000;
    uint256 totalSupplyIncrement = 1000;
    address owner;
    event supplyChange(uint totalSupply);
    mapping(address => uint) public balances;


    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    function getTotalSupply() public view returns(uint256) {
        return totalSupply;
    }

    function increaseSupply() public onlyOwner {
        totalSupply = totalSupply + totalSupplyIncrement;
        emit supplyChange(totalSupply);
    }



}