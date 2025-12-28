// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract RomanNumerals {
    // 将整数转换为罗马数字
    function intToRoman(uint256 num) public pure returns (string memory) {
        require(num >= 1 && num <= 3999, "Input must be between 1 and 3999");

        uint256[] memory values = new uint256[](13);
        string[] memory symbols = new string[](13);

        // 按从大到小顺序填充
        values[0] = 1000;
        symbols[0] = "M";
        values[1] = 900;
        symbols[1] = "CM";
        values[2] = 500;
        symbols[2] = "D";
        values[3] = 400;
        symbols[3] = "CD";
        values[4] = 100;
        symbols[4] = "C";
        values[5] = 90;
        symbols[5] = "XC";
        values[6] = 50;
        symbols[6] = "L";
        values[7] = 40;
        symbols[7] = "XL";
        values[8] = 10;
        symbols[8] = "X";
        values[9] = 9;
        symbols[9] = "IX";
        values[10] = 5;
        symbols[10] = "V";
        values[11] = 4;
        symbols[11] = "IV";
        values[12] = 1;
        symbols[12] = "I";

        bytes memory result;

        for (uint256 i = 0; i < 13; i++) {
            while (num >= values[i]) {
                num -= values[i];
                result = abi.encodePacked(result, symbols[i]);
            }
        }

        return string(result);
    }

    struct RomanPair {
        uint256 value;
        string symbol;
    }

    function intToRomanV2(uint256 num) public pure returns (string memory) {
        require(num >= 1 && num <= 3999, "Number must be between 1 and 3999");

        RomanPair[] memory roman = new RomanPair[](13);

        roman[0] = RomanPair(1000, "M");
        roman[1] = RomanPair(900, "CM");
        roman[2] = RomanPair(500, "D");
        roman[3] = RomanPair(400, "CD");
        roman[4] = RomanPair(100, "C");
        roman[5] = RomanPair(90, "XC");
        roman[6] = RomanPair(50, "L");
        roman[7] = RomanPair(40, "XL");
        roman[8] = RomanPair(10, "X");
        roman[9] = RomanPair(9, "IX");
        roman[10] = RomanPair(5, "V");
        roman[11] = RomanPair(4, "IV");
        roman[12] = RomanPair(1, "I");

        string memory result = "";

        for (uint256 i = 0; i < roman.length; i++) {
            while (num >= roman[i].value) {
                result = string(abi.encodePacked(result, roman[i].symbol));
                num -= roman[i].value;
            }
        }
        return result;
    }
}
