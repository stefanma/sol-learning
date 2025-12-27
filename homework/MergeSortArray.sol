// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract MergeSortArray {
    function merge(
        uint[] memory nums1,
        uint[] memory nums2
    ) public pure returns (uint[] memory) {
        uint i = 0;
        uint j = 0;
        uint k = 0;

        uint total = nums1.length + nums2.length;
        uint[] memory result = new uint[](total);

        while (i < nums1.length && j < nums2.length) {
            if (nums1[i] <= nums2[j]) {
                result[k++] = nums1[i++];
            } else {
                result[k++] = nums2[j++];
            }
        }

        while (i < nums1.length) {
            result[k++] = nums1[i++];
        }

        while (j < nums2.length) {
            result[k++] = nums2[j++];
        }

        return result;
    }
}
