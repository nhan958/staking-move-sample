module staking_admin::stake {
    use std::signer::address_of;

    use aptos_framework::account::{create_resource_account, SignerCapability, create_signer_with_capability};
    use aptos_framework::coin;

    #[test_only]
    use staking_admin::coins;

    //error codes

    const E_STAKE_NOT_FOUND: u64 = 0;
    const E_STAKE_ALREADY_EXISTS: u64 = 1;
    const E_STAKE_ALREADY_WITHDRAWN: u64 = 2;
    const ONLY_ALLOW_OWNER: u64 = 3;

    struct Info<phantom TokenType> has key, store {
        amount: u64,
        resource: address,
        resource_cap: SignerCapability,
    }

    public entry fun deposit<TokenType>(signer: &signer, amount: u64) acquires Info {
        let signer_address = address_of(signer);
        let address_re;
        if (!exists<Info<TokenType>>(signer_address)) {
            let (_resource, _resource_cap) = create_resource_account(signer, b"0x1");
            coin::register<TokenType>(&_resource);
            move_to<Info<TokenType>>(signer, Info<TokenType> {
                amount: 0,
                resource: address_of(&_resource),
                resource_cap: _resource_cap
            });
            address_re = address_of(&_resource);
        }else {
            let info = borrow_global<Info<TokenType>>(signer_address);
            address_re = info.resource;
        };
        let info_mut = borrow_global_mut<Info<TokenType>>(signer_address);
        coin::transfer<TokenType>(signer, address_re, amount);
        info_mut.amount = info_mut.amount + amount;
    }

    public entry fun withdraw<TokenType>(sender: &signer, amount: u64) acquires Info {
        let sender_address = address_of(sender);
        assert!(exists<Info<TokenType>>(sender_address), 0);
        let info = borrow_global_mut<Info<TokenType>>(sender_address);
        assert!(info.amount > 0 && info.amount >= amount, 1);
        info.amount = 0;
        let signer_from_cap = create_signer_with_capability(&info.resource_cap);
        coin::transfer<TokenType>(&signer_from_cap, sender_address, amount);
    }


    #[test(_sender = @staking_admin)]
    public entry fun init(_sender: &signer) acquires Info {
        use aptos_framework::aptos_account;
        let ini_balance: u64 = 10000000;

        aptos_account::create_account(address_of(_sender));
        coins::register_coins(_sender);

        coin::register<coins::BTC>(_sender);
        coins::mint_coin<coins::BTC>(_sender, address_of(_sender), ini_balance);

        deposit<coins::BTC>(_sender, 1000);
        withdraw<coins::BTC>(_sender, 500);
        let balance = coin::balance<coins::BTC>(address_of(_sender));
        assert!(balance == ini_balance - 500, 0);
    }
}
