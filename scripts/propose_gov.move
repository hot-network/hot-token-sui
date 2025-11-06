script {
    use hot_token::governance;

    fun main(proposer: address, value: u64) -> u64 {
        let proposal = borrow_global_mut<Proposal>(proposer);
        governance::propose(proposal, value);
        proposal.id
    }
}
