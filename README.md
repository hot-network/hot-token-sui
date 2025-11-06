# HOT Token - Sui Blockchain

**HOT Token** is a fully featured **deflationary token** on the Sui blockchain with **staking, governance, transaction fees, and automated reward systems**. This package is fully deployable on **Devnet or Mainnet**.

---

## **Features**

* HOT Token (`hot_token`)

  * Initial supply: 18,000,000,000 HOT
  * Transaction fee: 1.5% per transfer, sent to fee wallet
  * Quarterly 0.25% burn (max 50% total supply)
  * On-chain metadata for wallet and explorer discovery

* **Staking**

  * Stake and unstake HOT tokens
  * Claim staking rewards
  * Pause/resume staking

* **Governance**

  * Create, vote, and execute proposals
  * Voting power proportional to staked tokens

* **Utilities**

  * Gas-efficient arithmetic
  * Helper functions for modular logic

* **Master Script (`hot_master.js`)**

  * Fully automates post-deployment operations: minting, staking, rewards, governance, deflation, and fee management

---

## **Folder Structure**

```
hot_token/
├── Move.toml
├── package.json
├── README.md
├── hot_master.js
├── sources/
│   ├── hot.move
│   ├── staking.move
│   ├── governance.move
│   └── utils.move
├── scripts/
│   ├── init_hot.move
│   ├── mint_hot.move
│   ├── transfer_hot.move
│   ├── deflate_hot.move
│   ├── stake_hot.move
│   ├── unstake_hot.move
│   ├── claim_rewards.move
│   ├── propose_gov.move
│   ├── vote_gov.move
│   ├── execute_gov.move
│   ├── pause_staking.move
│   ├── resume_staking.move
│   ├── set_fee_rate.move
│   ├── config_devnet.move
│   └── config_mainnet.move
└── tests/
    └── token_tests.move
```

---

## **Installation**

1. Clone or download the repository.
2. Navigate to the package folder:

```bash
cd hot_token
```

3. Install Node.js dependencies:

```bash
npm install
```

---

## **Build & Test**

1. Compile Move modules:

```bash
npm run build
```

2. Run automated tests:

```bash
npm run test
```

---

## **Deployment**

* Deploy to **Devnet**:

```bash
npm run publish:devnet
```

* Deploy to **Mainnet**:

```bash
npm run publish:mainnet
```

> Make sure to update the `CONFIG.network` in `hot_master.js` to match your deployment target.

---

## **Post-Deployment Operations with Master Script**

The `hot_master.js` script automates all core operations:

1. Initializes HOT token with **metadata** and **fee wallet**
2. Mints initial HOT supply to configured wallets
3. Stakes tokens and claims rewards
4. Governance operations: propose fee change, vote, and execute
5. Applies **quarterly deflation burn**
6. Admin controls: pause/resume staking

### **Run the Master Script**

1. Edit `hot_master.js`:

* Set your `adminPrivateKey` (Base64)
* Set `feeWallet`
* Add initial wallets to receive HOT tokens

2. Run:

```bash
node hot_master.js
```

> The script logs each step and automatically handles errors.

---

## **Scripts Overview**

| Script                | Function                                            |
| --------------------- | --------------------------------------------------- |
| `init_hot.move`       | Deploy HOT token with metadata and fee wallet       |
| `mint_hot.move`       | Mint HOT tokens to a wallet                         |
| `transfer_hot.move`   | Transfer HOT tokens with 1.5% fee                   |
| `deflate_hot.move`    | Apply quarterly 0.25% burn (up to 50% total supply) |
| `stake_hot.move`      | Stake HOT tokens                                    |
| `unstake_hot.move`    | Unstake HOT tokens                                  |
| `claim_rewards.move`  | Claim staking rewards                               |
| `propose_gov.move`    | Create a governance proposal                        |
| `vote_gov.move`       | Vote on a governance proposal                       |
| `execute_gov.move`    | Execute a proposal if approved                      |
| `pause_staking.move`  | Pause staking functionality                         |
| `resume_staking.move` | Resume staking functionality                        |
| `set_fee_rate.move`   | Admin-only transaction fee adjustment               |
| `config_devnet.move`  | Devnet configuration placeholder                    |
| `config_mainnet.move` | Mainnet configuration placeholder                   |

---

## **Notes**

* The package is **fully modular** and optimized for gas efficiency.
* Ensure all private keys are kept **secure**.
* The fee wallet receives **all transaction fees** automatically.
* Deflation logic automatically stops when **50% of total supply is burned**.
