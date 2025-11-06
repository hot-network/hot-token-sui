script {
    use hot_token::hot;

    fun main(from: address, to: address, amount: u64) {
        let token = borrow_global_mut<HOT>(from);
        hot::transfer(token, from, to, amount);
    }
}
