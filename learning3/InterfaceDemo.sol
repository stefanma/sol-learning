// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

interface IERC20 {
    function transfer(address to, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

contract ERC20 is IERC20 {
    function transfer(address to, uint256 amount) public returns (bool) {
        return false;
    }
    
    function balanceOf(address account) public view returns (uint256) {
        return 1;
    }
}
