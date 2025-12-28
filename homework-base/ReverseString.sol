// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract ReverseString {
    function reverseString(
        string memory input
    ) public pure returns (string memory) {
        // 将字符串转换为字节数组
        bytes memory inputBytes = bytes(input);
        uint256 length = inputBytes.length;

        // 如果字符串为空或只有一个字符，直接返回
        if (length <= 1) {
            return input;
        }

        // 创建新的字节数组用于存储反转结果
        bytes memory reversedBytes = new bytes(length);

        // 反转字节数组
        for (uint256 i = 0; i < length; i++) {
            reversedBytes[i] = inputBytes[length - 1 - i];
        }

        // 将字节数组转换回字符串并返回
        return string(reversedBytes);
    }

    function reverseStringAlternative(
        string memory input
    ) public pure returns (string memory) {
        bytes memory strBytes = bytes(input);
        uint256 len = strBytes.length;

        if (len <= 1) {
            return input;
        }

        // 使用双指针法反转
        uint256 left = 0;
        uint256 right = len - 1;

        while (left < right) {
            // 交换字节
            bytes1 temp = strBytes[left];
            strBytes[left] = strBytes[right];
            strBytes[right] = temp;

            left++;
            right--;
        }

        return string(strBytes);
    }

    // 反转字符串
    function reverse(string memory input) public pure returns (string memory) {
        bytes memory strBytes = bytes(input);
        uint length = strBytes.length;

        bytes memory reversed = new bytes(length);

        for (uint i = 0; i < length; i++) {
            reversed[i] = strBytes[length - 1 - i];
        }

        return string(reversed);
    }
}
