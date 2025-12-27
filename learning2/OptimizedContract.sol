// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract UnoptimizedContract {
    uint256[] public array;

    // 优化1：使用calldata替代memory
    function processArray(
        uint[] calldata data // 避免内存复制，节省~3,000 gas
    ) external {
        uint256 len = data.length; // 优化2：缓存length

        // 优化3：预先计算，减少storage操作
        for (uint i = 0; i < len; i++) {
            array.push(data[i]);
        }
    }

    // 优化4：缓存storage变量
    function getLength() external view returns (uint256) {
        uint256 sum = 0;
        uint256 len = array.length; // 只读取一次storage

        for (uint i = 0; i < len; i++) {
            sum += array[i];
        }
        return sum;
    }
}
