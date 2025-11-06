script {
    use hot_token::hot;

    fun main(fee_wallet: address, decimals: u8, metadata: vector<u8>) {
        let _token = hot::init(&mut TxContext::new(), fee_wallet, decimals, metadata);
    }
}
