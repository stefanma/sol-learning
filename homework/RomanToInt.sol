// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;
contract RomanToInt {
    function romanToInt(string memory s) public pure returns (uint) {
        bytes memory data = bytes(s);
        uint total = 0;
        uint i = 0;

        while (i < data.length) {
            uint curr = valueOf(data[i]);

            // 如果有下一个字符，检查是否是减法组合
            if (i + 1 < data.length) {
                uint next = valueOf(data[i + 1]);

                if (curr < next) {
                    total += (next - curr);
                    i += 2; // 跳过两个字符
                    continue;
                }
            }

            total += curr;
            i++;
        }

        return total;
    }

    function valueOf(bytes1 c) private pure returns (uint) {
        if (c == "I") return 1;
        if (c == "V") return 5;
        if (c == "X") return 10;
        if (c == "L") return 50;
        if (c == "C") return 100;
        if (c == "D") return 500;
        if (c == "M") return 1000;
        revert("Invalid Roman character");
    }
}
