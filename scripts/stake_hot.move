script {
    use hot_token::staking;

    fun main(stake_owner: address, amount: u64) {
        let stake = borrow_global_mut<Stake>(stake_owner);
        staking::unstake(stake, amount);
    }
}
