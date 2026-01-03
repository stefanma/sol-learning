// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

library MathLib {
    // 安全加法
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "MathLib: addition overflow");
        return c;
    }

    // 安全减法
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, "MathLib: subtraction underflow");
        return a - b;
    }

    // 安全乘法
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }
        uint256 c = a * b;
        require(c / a == b, "MathLib: multiplication overflow");
        return c;
    }

    // 安全除法
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b > 0, "MathLib: division by zero");
        return a / b;
    }
}

contract MathCalculator_Tradition {
    function calculate(uint256 x, uint256 y) public pure returns (uint256) {
        // 传统方式：需要显式指定库名
        uint256 sum = MathLib.add(x, y);
        uint256 product = MathLib.mul(sum, 2);
        return product;
    }
}

contract MathCalculator_UsingFor {
    using MathLib for uint256;

    function calculate(uint256 x, uint256 y) public pure returns (uint256) {
        // 更自然的调用方式
        uint256 sum = x.add(y);
        uint256 product = sum.mul(2);
        return product;
    }

    function complexCalculation(
        uint256 a,
        uint256 b,
        uint256 c
    ) public pure returns (uint256) {
        // 链式调用
        return a.add(b).mul(c).div(2);
    }
}
