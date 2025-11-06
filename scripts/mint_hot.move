script {
    use hot_token::hot;

    fun main(recipient: address, amount: u64) {
        let token = borrow_global_mut<HOT>(signer::address_of(&signer));
        hot::mint(token, recipient, amount);
    }
}
