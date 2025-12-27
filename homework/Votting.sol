// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract Votting {
    // 1. 候选人 => 票数
    mapping(string => uint256) private votes;

    // 用于遍历的候选人列表
    string[] private candidates;

    // 防止重复加入候选人
    mapping(string => bool) private candidateExists;

    // 合约部署者
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    // 2. 投票
    function vote(string memory candidate) public {
        // 如果是新候选人，加入列表
        if (!candidateExists[candidate]) {
            candidates.push(candidate);
            candidateExists[candidate] = true;
        }
        votes[candidate] += 1;
    }

    // 3. 查询票数
    function getVotes(string memory candidate) public view returns (uint256) {
        return votes[candidate];
    }

    // 4. 重置所有票数（只有合约创建者可以）
    function resetVotes() public {
        require(msg.sender == owner, "Only owner can reset votes");

        for (uint256 i = 0; i < candidates.length; i++) {
            string memory candidate = candidates[i];
            votes[candidate] = 0;
        }
    }

    // 获取所有候选人
    function getAllCandidates() public view returns (string[] memory) {
        return candidates;
    }
}
