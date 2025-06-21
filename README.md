# 💸 Paylog

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Build Status](https://img.shields.io/github/actions/workflow/status/YOUR_GITHUB_USERNAME/Paylog/ci.yml)](https://github.com/YOUR_GITHUB_USERNAME/Paylog/actions)
[![Solidity](https://img.shields.io/badge/Solidity-^0.8.20-lightgrey.svg)](https://soliditylang.org/)
[![Tests](https://img.shields.io/badge/tests-passing-brightgreen.svg)](#)

> **Paylog** is a secure and auditable smart contract system for logging and disbursing payments on-chain — built for DAOs, treasury managers, and organizations who want to pay transparently.

---

## 📚 Table of Contents

- [Features](#features)
- [Use Cases](#use-cases)
- [Architecture](#architecture)
- [Installation](#installation)
- [Usage](#usage)
- [Contract Interface](#contract-interface)
- [Testing](#testing)
- [Security](#security)
- [Contributing](#contributing)
- [License](#license)

---

## ✨ Features

- 🔐 **Admin-Only Payment Logging**
- ⏰ **Optional Delayed Payment Release**
- 🧾 **Transparent Record of Every Transaction**
- 🧑‍💼 **Supports Individual and Batch Payouts**
- 📦 **Structured Payment Memos (metadata or invoice references)**
- 🧠 **Easily Extensible for Payroll, Bounties, Grants**

---

## 🧑‍💻 Use Cases

- DAO contributor salary payouts
- Grant milestone disbursements
- Bounty program settlements
- Freelance/contractor invoice payment
- Accounting-friendly crypto bookkeeping

---

## 🏗️ Architecture

```mermaid
graph TD
    A[Owner/Admin] -->|Log Payment| B[Paylog Contract]
    B --> C[Store Struct]
    D[Release Conditions Met] -->|Trigger| E[releasePayment]
    E --> F[ERC20 Transfer to Recipient]
    B --> G[Event Emission]
🔧 Installation
bash
git clone https://github.com/YOUR_GITHUB_USERNAME/Paylog.git
cd Paylog
npm install
Requires Node.js ≥ 18, Hardhat, TypeScript, and Ethers.js

🚀 Usage
Compile Contracts
bash
npx hardhat compile
Deploy to Local/Testnet
bash
npx hardhat run scripts/deploy.ts --network goerli
Create a Payment
bash
npx hardhat record-payment --recipient <0xAddress> --amount 1000 --memo "Dev Grant Q2"
Release a Payment
bash
npx hardhat release-payment --paymentId 1
🧾 Contract Interface
Paylog.sol
Struct
solidity
struct Payment {
  address recipient;
  uint256 amount;
  uint256 releaseTime;
  bool released;
  string memo;
}
Functions
solidity
function recordPayment(
  address recipient,
  uint256 amount,
  uint256 releaseTime,
  string calldata memo
) external onlyOwner;

function releasePayment(uint256 paymentId) external onlyOwner;

function getPaymentLog(uint256 paymentId) public view returns (Payment memory);
Events
solidity
event PaymentLogged(uint256 indexed paymentId, address indexed recipient, uint256 amount, string memo);
event PaymentReleased(uint256 indexed paymentId, address indexed recipient, uint256 amount);
🧪 Testing
bash

npx hardhat test
Test coverage includes:

✅ Payment creation and ID generation

✅ Timelock enforcement (if releaseTime > block.timestamp)

✅ Unauthorized access reverts

✅ Payment double-spend prevention

🔐 Security
🔒 Owner-only permission control

✅ Prevents double-releases

🧠 Uses block.timestamp safely

📣 Full audit recommended before mainnet deployment

🤝 Contributing
Contributions are welcome! Please fork the repo and open a pull request.

Dev Workflow
bash
git checkout -b feature/my-feature
npm run test
git commit -m "feat: add my-feature"
git push origin feature/my-feature
Code Quality
✅ Lint with solhint

✅ Format with prettier

✅ Write and run tests


🌐 Future Enhancements
 Streamed/linear payments (drip-based)

 Token type abstraction (ERC20/ERC777/NFT royalties)

 Role-based payment logging (multi-signer)

 Payment dispute or cancellation logic

