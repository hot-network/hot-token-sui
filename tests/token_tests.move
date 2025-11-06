module hot_token::token_tests {
    use sui::test;
    use sui::tx_context;
    use hot_token::hot;
    use hot_token::staking;
    use hot_token::governance;

    #[test]
    public fun test_mint(ctx: &mut tx_context::TxContext) {
        let recipient = test::create_account(ctx);
        let token = hot::mint(&recipient, 1000, ctx);
        test::assert(token.amount == 1000, 1);
    }

    #[test]
    public fun test_transfer_with_fee(ctx: &mut tx_context::TxContext) {
        let sender = test::create_account(ctx);
        let receiver = test::create_account(ctx);
        let token = hot::mint(&sender, 1000, ctx);
        let fee_wallet = hot::get_fee_wallet();
        let transferred_amount = hot::transfer(&sender, &receiver, 500, ctx);
        let expected_fee = 500 * 15 / 1000;
        let expected_receiver = 500 - expected_fee;
        test::assert(transferred_amount == expected_receiver, 2);
        let fee_balance = hot::balance_of(&fee_wallet);
        test::assert(fee_balance >= expected_fee, 3);
    }

    #[test]
    public fun test_deflation(ctx: &mut tx_context::TxContext) {
        let account = test::create_account(ctx);
        let token = hot::mint(&account, 1000, ctx);
        hot::deflate(&account, ctx);
        let burned = token.amount / 400;
        test::assert(hot::total_burned() == burned, 4);
    }

    #[test]
    public fun test_staking(ctx: &mut tx_context::TxContext) {
        let staker = test::create_account(ctx);
        hot::mint(&staker, 1000, ctx);
        staking::stake(&staker, 500, ctx);
        let staked_balance = staking::staked_balance(&staker);
        test::assert(staked_balance == 500, 5);
        staking::claim_rewards(&staker, ctx);
        let rewards = staking::rewards_balance(&staker);
        test::assert(rewards > 0, 6);
        staking::unstake(&staker, 500, ctx);
        test::assert(staking::staked_balance(&staker) == 0, 7);
    }

    #[test]
    public fun test_governance(ctx: &mut tx_context::TxContext) {
        let proposer = test::create_account(ctx);
        let voter1 = test::create_account(ctx);
        let voter2 = test::create_account(ctx);
        let proposal_id = governance::propose(&proposer, 200, ctx);
        governance::vote(&voter1, proposal_id, true, ctx);
        governance::vote(&voter2, proposal_id, true, ctx);
        governance::execute(proposal_id, ctx);
        let fee_rate = hot::get_fee_rate();
        test::assert(fee_rate == 200, 8);
    }
}
