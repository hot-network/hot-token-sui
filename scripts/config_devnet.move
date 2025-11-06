module hot_token::config_devnet {
    use hot_token::hot;

    public fun set_devnet_config() {
        hot::set_fee_wallet(0xFEEDEVNET);
    }
}