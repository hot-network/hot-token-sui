module hot_token::governance_scripts {
    use hot_token::governance;
    use sui::tx_context;

    public fun propose(account: address, new_fee_rate: u64, ctx: &mut tx_context::TxContext): u64 {
        governance::propose(&account, new_fee_rate, ctx)
    }

    public fun vote(account: address, proposal_id: u64, approve: bool, ctx: &mut tx_context::TxContext) {
        governance::vote(&account, proposal_id, approve, ctx);
    }

    public fun execute(proposal_id: u64, ctx: &mut tx_context::TxContext) {
        governance::execute(proposal_id, ctx);
    }
}
