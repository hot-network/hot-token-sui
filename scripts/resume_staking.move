script {
    use hot_token::staking;

    fun main(stake_owner: address) {
        let stake = borrow_global_mut<Stake>(stake_owner);
        staking::resume(stake);
    }
}
