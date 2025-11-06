module hot_token::governance {
    use sui::object::*;

    struct Proposal has store {
        id: u64,
        proposer: address,
        value: u64,
        executed: bool,
        votes_for: u64,
        votes_against: u64,
    }

    public fun propose(proposal: &mut Proposal, value: u64) {
        proposal.value = value;
        proposal.executed = false;
        proposal.votes_for = 0;
        proposal.votes_against = 0;
    }

    public fun vote(proposal: &mut Proposal, support: bool, weight: u64) {
        if support {
            proposal.votes_for = proposal.votes_for + weight;
        } else {
            proposal.votes_against = proposal.votes_against + weight;
        }
    }

    public fun execute(proposal: &mut Proposal) {
        assert(!proposal.executed, 1);
        if proposal.votes_for > proposal.votes_against {
            proposal.executed = true;
            // implement effect: e.g., set_fee_rate
        }
    }
}
