module hot_token::staking {
    use sui::object::*;
    use sui::vector::*;
    use sui::tx_context::*;

    struct Stake has store {
        owner: address,
        amount: u64,
        rewards: u64,
        paused: bool,
    }

    public fun stake(stake: &mut Stake, amount: u64) {
        assert(!stake.paused, 1);
        stake.amount = stake.amount + amount;
        stake.rewards = stake.rewards + calculate_rewards(amount);
    }

    public fun unstake(stake: &mut Stake, amount: u64) {
        assert(stake.amount >= amount, 2);
        stake.amount = stake.amount - amount;
        // rewards remain claimable
    }

    public fun claim_rewards(stake: &mut Stake) -> u64 {
        let r = stake.rewards;
        stake.rewards = 0;
        r
    }

    fun calculate_rewards(amount: u64): u64 {
        amount / 100 // simple 1% reward for demonstration
    }

    public fun pause(stake: &mut Stake) { stake.paused = true; }
    public fun resume(stake: &mut Stake) { stake.paused = false; }
}
