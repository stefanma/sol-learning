// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract BeggingContract {
    address public owner;
    // 每个地址的捐赠金额
    mapping(address => uint256) public donations;

    // 所有捐赠过的地址
    address[] public donors;

    // 用于判断是否已经加入 donors 数组
    mapping(address => bool) private donatedBefore;

    // 捐赠时间限制
    uint256 public startTime;
    uint256 public endTime;

    // 捐赠事件
    event Donation(address indexed donor, uint256 amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    modifier withinTime() {
        require(
            block.timestamp >= startTime && block.timestamp <= endTime,
            "Not in donation period"
        );
        _;
    }

    constructor(uint256 _startTime, uint256 _endTime) {
        owner = msg.sender;
        startTime = _startTime;
        endTime = _endTime;
    }

    // 捐赠函数
    function donate() external payable withinTime {
        require(msg.value > 0, "Donation amount must be greater than 0");
        if (!donatedBefore[msg.sender]) {
            donors.push(msg.sender);
            donatedBefore[msg.sender] = true;
        }

        donations[msg.sender] += msg.value;

        emit Donation(msg.sender, msg.value);
    }

    // 查询某个地址的捐赠金额
    function getDonation(address _addr) external view returns (uint256) {
        return donations[_addr];
    }

    // 提取所有资金：仅所有者可调用
    function withdraw() external onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "No funds to withdraw");
        payable(owner).transfer(balance);
    }

    // 获取捐赠排行榜：前3个捐赠金额最多的地址（简单冒泡排序实现）
    function getTopDonors()
        external
        view
        returns (address[3] memory topAddresses, uint256[3] memory topAmounts)
    {
        uint256 donorCount = donors.length;
        if (donorCount == 0) {
            return (topAddresses, topAmounts);
        }

        // 创建临时数组用于排序
        address[] memory sortedDonors = new address[](donorCount);
        uint256[] memory sortedAmounts = new uint256[](donorCount);

        // 复制数据
        for (uint256 i = 0; i < donorCount; i++) {
            sortedDonors[i] = donors[i];
            sortedAmounts[i] = donations[donors[i]];
        }

        // 简单冒泡排序（降序，按金额排序；注意：生产环境若捐助者多，可优化或移到链下）
        for (uint256 i = 0; i < donorCount - 1; i++) {
            for (uint256 j = 0; j < donorCount - i - 1; j++) {
                if (sortedAmounts[j] < sortedAmounts[j + 1]) {
                    // 交换金额
                    uint256 tempAmount = sortedAmounts[j];
                    sortedAmounts[j] = sortedAmounts[j + 1];
                    sortedAmounts[j + 1] = tempAmount;

                    // 交换地址
                    address tempAddr = sortedDonors[j];
                    sortedDonors[j] = sortedDonors[j + 1];
                    sortedDonors[j + 1] = tempAddr;
                }
            }
        }

        // 返回前3（如果捐助者少于3，返回所有）
        uint256 limit = donorCount < 3 ? donorCount : 3;
        for (uint256 i = 0; i < limit; i++) {
            topAddresses[i] = sortedDonors[i];
            topAmounts[i] = sortedAmounts[i];
        }

        return (topAddresses, topAmounts);
    }
}
