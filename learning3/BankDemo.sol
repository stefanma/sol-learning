// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract BankDemo {
    mapping(address => uint256) public balances;

    // 自定义修饰符，检查余额是否足够
    modifier hasSufficientBalance(uint256 amount) {
        require(balances[msg.sender] >= amount, "yu er bu zu...");
        _;
    }
    // 存款函数
    function deposit() public payable {
        require(msg.value > 0, "cun kuan jin er bi xu da yu 0");
        balances[msg.sender] += msg.value;
    }

    // 取款函数
    function withdraw(uint256 amount) public hasSufficientBalance(amount) {
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        assert(balances[msg.sender] >= 0); // 确保余额不为负
    }
}
