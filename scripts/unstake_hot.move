module hot_token::unstake_hot {
    use hot_token::staking;
    use sui::tx_context;

    /// Unstake HOT tokens
    /// `account` is the user unstaking
    /// `amount` is the number of tokens to unstake
    public fun unstake(account: address, amount: u64, ctx: &mut tx_context::TxContext) {
        // Ensure staking is active
        assert!(!staking::is_paused(), 1);

        // Unstake the specified amount
        staking::unstake(&account, amount, ctx);
    }
}
