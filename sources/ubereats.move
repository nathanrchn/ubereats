module ubereats::ubereats {
    use sui::sui::SUI;
    use sui::coin::Coin;
    use sui::clock::Clock;
    use sui::object::{Self, UID};
    use sui::tx_context::TxContext;
    
    use guava_order::order::{Self, Order, WrappedObject};

    struct Burger has key, store {
        id: UID
    }

    entry fun order_burger(restaurant: address, coin: Coin<SUI>, length: u64, total_length: u64, clock: &Clock, ctx: &mut TxContext) {
        order::create_order<Burger, SUI>(restaurant, coin, length, total_length, clock, ctx);
    }

    entry fun prepare_burger(order: &mut Order<Burger, SUI>, ctx: &mut TxContext) {
        order::wrap_object(order, Burger { id: object::new(ctx) }, ctx)
    }

    entry fun deliver_burger(order: &mut Order<Burger, SUI>, wrap_burger: WrappedObject<Burger>, clock: &Clock, ctx: &mut TxContext) {
        order::fulfill_order(order, wrap_burger, clock, ctx);
    }
}