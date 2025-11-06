module hot_token::config_mainnet {
    use hot_token::hot;

    public fun set_mainnet_config() {
        hot::set_fee_wallet(0xFEEMAIN);
    }
}
