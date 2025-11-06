script {
    use hot_token::hot;

    fun main() {
        let token = borrow_global_mut<HOT>(signer::address_of(&signer));
        hot::deflate(token);
    }
}
