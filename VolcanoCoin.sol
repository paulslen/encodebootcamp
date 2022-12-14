// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract VolcanoCoin is Ownable {

    uint256 totalSupply = 10000;
    uint256 totalSupplyIncrement = 1000;
    address owner;
    event supplyChange(uint totalSupply);
    event transferEvent(uint amount, address receiver);
    mapping(address => uint) public balances;
    
    struct Payment{
        address recipient;
        uint256 amount;
    }
    Payment[] public payments;
    mapping(address => Payment[]) public paymentRecords;

    constructor() {
        owner = msg.sender;
        balances[owner] = totalSupply;
    }

    function getBalance(address _address) public view returns(uint256) {
        uint256 balance = balances[_address];
        return balance;
    }

    function viewPayment(address _address) public view returns(Payment[]) {
        return payments;
    }

    function getTotalSupply() public view returns(uint256) {
        return totalSupply;
    }

    function increaseSupply() public onlyOwner {
        totalSupply = totalSupply + totalSupplyIncrement;
        emit supplyChange(totalSupply);
    }

    function transfer(uint256 _amount, address _to) public {
        require(balances[msg.sender] > _amount);
        balances[msg.sender] - _amount;
        balances[_to] + _amount;
        paymentRecords[msg.sender].push(Payment(_to, _amount));
        emit transferEvent({amount: _amount, receiver:_to});
    }

}