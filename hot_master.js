import { JsonRpcProvider, RawSigner, Ed25519Keypair, fromB64, devnetConnection, mainnetConnection } from "@mysten/sui.js";

const CONFIG = {
    network: "devnet", // "mainnet" for Mainnet deployment
    adminPrivateKey: "<ADMIN_PRIVATE_KEY_BASE64>",
    feeWallet: "<FEE_WALLET_ADDRESS>",
    hotTokenModule: "hot_token",
    decimals: 9,
    metadata: "HOT Token - Deflationary, Staking, Governance",
    initialMintWallets: ["<WALLET_ADDRESS_1>", "<WALLET_ADDRESS_2>"],
    initialMintAmount: 18_000_000_000,
    stakingAmount: 1_000_000_000,
    governanceFeeRate: 15, // Example fee change
};

const provider = new JsonRpcProvider(
    CONFIG.network === "devnet" ? devnetConnection : mainnetConnection
);
const adminKeypair = Ed25519Keypair.fromSecretKey(fromB64(CONFIG.adminPrivateKey));
const signer = new RawSigner(adminKeypair, provider);

async function executeMove(module, func, args = []) {
    console.log(`Executing: ${module}::${func}`);
    try {
        const result = await signer.executeMoveCall({
            packageObjectId: CONFIG.hotTokenModule,
            module,
            function: func,
            typeArguments: [],
            arguments: args,
            gasBudget: 300_000
        });
        console.log(`✅ Success: ${module}::${func}`);
        return result;
    } catch (err) {
        console.error(`❌ Failed: ${module}::${func}`, err);
    }
}

async function masterFlow() {
    console.log("🚀 HOT Token Master Script Started");

    // 1️⃣ Initialize HOT token with metadata & fee wallet
    await executeMove("init_hot", "init", [CONFIG.feeWallet, CONFIG.decimals, Array.from(Buffer.from(CONFIG.metadata))]);

    // 2️⃣ Mint initial supply to wallets
    for (const wallet of CONFIG.initialMintWallets) {
        await executeMove("mint_hot", "mint", [wallet, CONFIG.initialMintAmount]);
    }

    // 3️⃣ Stake some tokens
    await executeMove("stake_hot", "stake", [CONFIG.adminPrivateKey, CONFIG.stakingAmount]);

    // 4️⃣ Claim staking rewards
    await executeMove("claim_rewards", "claim_rewards", [CONFIG.adminPrivateKey]);

    // 5️⃣ Governance: propose, vote, execute fee rate change
    const proposalId = await executeMove("propose_gov", "propose", [CONFIG.adminPrivateKey, CONFIG.governanceFeeRate]);
    await executeMove("vote_gov", "vote", [proposalId, true, CONFIG.stakingAmount]);
    await executeMove("execute_gov", "execute", [proposalId]);

    // 6️⃣ Apply deflation (quarterly 0.25% burn)
    await executeMove("deflate_hot", "deflate");

    // 7️⃣ Optional staking admin controls
    await executeMove("pause_staking", "pause", [CONFIG.adminPrivateKey]);
    await executeMove("resume_staking", "resume", [CONFIG.adminPrivateKey]);

    console.log("✅ HOT Token Master Script Completed Successfully");
}

// Run the master flow
masterFlow().catch(err => console.error("Master script failed:", err));
