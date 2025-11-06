script {
    use hot_token::hot;

    fun main(new_fee_rate: u64) {
        let token = borrow_global_mut<HOT>(signer::address_of(&signer));
        token.fee_rate = new_fee_rate; // Admin only
    }
}
