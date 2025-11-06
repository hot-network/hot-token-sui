module hot_token::hot {
    use sui::object::*;
    use sui::balance::*;
    use sui::tx_context::*;
    use sui::vector::*;

    struct HOT has store, key {
        total_supply: u64,
        burned: u64,
        fee_wallet: address,
        decimals: u8,
        metadata: vector<u8>,
    }

    public fun init(ctx: &mut TxContext, fee_wallet: address, decimals: u8, metadata: vector<u8>): HOT {
        HOT { total_supply: 0, burned: 0, fee_wallet, decimals, metadata }
    }

    public fun mint(token: &mut HOT, recipient: address, amount: u64) {
        token.total_supply = token.total_supply + amount;
        transfer_to(recipient, amount);
    }

    public fun transfer(token: &mut HOT, from: address, to: address, amount: u64) {
        let fee = amount * 15 / 1000; // 1.5%
        let send_amount = amount - fee;
        transfer_to(to, send_amount);
        transfer_to(token.fee_wallet, fee);
    }

    public fun deflate(token: &mut HOT) {
        let remaining = token.total_supply - token.burned;
        let burn_amount = remaining / 400; // 0.25%
        if token.burned + burn_amount > token.total_supply / 2 {
            token.burned = token.total_supply / 2;
        } else {
            token.burned = token.burned + burn_amount;
        }
        token.total_supply = token.total_supply - burn_amount;
    }
}
