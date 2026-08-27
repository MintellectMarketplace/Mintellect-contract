# Mintellect Marketplace Contracts

On-chain asset registry used by Mintellect Marketplace on BNB Smart Chain.

This repository publishes the verified Solidity source for the live `MintellectMint` contract.

## Deployed contract

| Field | Value |
| --- | --- |
| Network | BNB Smart Chain (BSC) |
| Contract | `MintellectMint` |
| Address | [`0xD37fbba4D6e562d029185bcaB1538aAF3497b11c`](https://bscscan.com/address/0xD37fbba4D6e562d029185bcaB1538aAF3497b11c#code) |
| Compiler | Solidity `^0.8.30` |
| License | MIT |

## What this contract does

`MintellectMint` records content assets on-chain:

- sequential `tokenId` starting at `1`
- `contentHash` (`bytes32`)
- `creator`
- `declaredTimestamp` (off-chain claimed time)
- `mintedAt` (`block.timestamp`)

It is a provenance / mint registry. It is **not** an ERC-721/ERC-1155 token and does not implement marketplace listing, payment, or royalty logic.

## Mint rules

Constructor argument: `ownerApprovalRequired`.

- If `true`: only `owner` can call `mint`.
- If `false`: `owner` or `creator` can call `mint`.
- `tokenId` must equal `nextTokenId`.
- `creator` and `contentHash` cannot be zero.
- `declaredTimestamp` must be greater than `0`.

## Source

```
contracts/MintellectMint.sol
```

Source in this repo matches the contract code provided from the BscScan verification page for the address above.

## License

MIT. See [LICENSE](LICENSE).
