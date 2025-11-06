script {
    use hot_token::governance;

    fun main(proposal_id: u64) {
        let proposal = borrow_global_mut<Proposal>(signer::address_of(&signer));
        governance::execute(proposal);
    }
}
