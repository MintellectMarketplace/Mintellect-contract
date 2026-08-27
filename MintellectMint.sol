// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract MintellectMint {
    struct AssetRecord {
        uint256 tokenId;
        bytes32 contentHash;
        address creator;
        uint256 declaredTimestamp;
        uint256 mintedAt;
    }

    address public owner;
    bool public immutable ownerApprovalRequired;
    uint256 public nextTokenId = 1;

    mapping(uint256 => AssetRecord) private records;

    event AssetMinted(
        uint256 indexed tokenId,
        bytes32 indexed contentHash,
        address indexed creator,
        uint256 declaredTimestamp,
        uint256 mintedAt,
        address operator
    );

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner");
        _;
    }

    constructor(bool _ownerApprovalRequired) {
        owner = msg.sender;
        ownerApprovalRequired = _ownerApprovalRequired;
    }

    function transferOwnership(address newOwner) external onlyOwner {
        require(newOwner != address(0), "Invalid owner");
        owner = newOwner;
    }

    function mint(
        uint256 tokenId,
        bytes32 contentHash,
        address creator,
        uint256 declaredTimestamp
    ) external returns (uint256) {
        require(creator != address(0), "Invalid creator");
        require(contentHash != bytes32(0), "Content hash required");
        require(declaredTimestamp > 0, "Timestamp required");
        require(tokenId == nextTokenId, "Unexpected tokenId");

        if (ownerApprovalRequired) {
            require(msg.sender == owner, "Owner approval required");
        } else {
            require(msg.sender == creator || msg.sender == owner, "Unauthorized minter");
        }

        uint256 mintedAt = block.timestamp;
        records[tokenId] = AssetRecord({
            tokenId: tokenId,
            contentHash: contentHash,
            creator: creator,
            declaredTimestamp: declaredTimestamp,
            mintedAt: mintedAt
        });
        nextTokenId = tokenId + 1;

        emit AssetMinted(tokenId, contentHash, creator, declaredTimestamp, mintedAt, msg.sender);
        return tokenId;
    }

    function getAsset(uint256 tokenId) external view returns (AssetRecord memory) {
        AssetRecord memory record = records[tokenId];
        require(record.creator != address(0), "Asset does not exist");
        return record;
    }

    function exists(uint256 tokenId) external view returns (bool) {
        return records[tokenId].creator != address(0);
    }
}
