// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;
contract UnoptimizedContract {
    
    uint256[] public array;

    // X 问题1：使用memory而不是calldata
    function processArray(
        uint[] memory data // 不必要的内存复制！
    ) external {
        //X 问题2：循环中直接写storage
        for (uint i = 0; i < data.length; i++) {
            array.push(data[i]); // 每次push都是昂贵的storage操作
        }
    }

    // X问题3：每次循环都读取storage的length
    function getLength() external view returns (uint256) {
        uint256 sum = 0;
        for (uint i = 0; i < array.length; i++) {
            // 反复SLOAD
            sum += array[i];
        }
        return sum;
    }
}
