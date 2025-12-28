// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract BinarySearch {
    function search(int[] memory nums, int target) public pure returns (int) {
        if (nums.length == 0) {
            return -1;
        }

        int left = 0;
        int right = int(nums.length) - 1;

        while (left <= right) {
            int mid = left + (right - left) / 2;

            if (nums[uint(mid)] == target) {
                return mid;
            }

            if (nums[uint(mid)] < target) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        return -1;
    }
}
