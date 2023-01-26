part of 'shop_bloc.dart';

abstract class ShopEvent extends Equatable {
  const ShopEvent();

  @override
  List<Object> get props => [];
}

class ShopPageInitializedEvent extends ShopEvent {}

// ignore: must_be_immutable
class ItemAddingCartEvent extends ShopEvent {
  List<Product> cartItems;

  ItemAddingCartEvent({required this.cartItems});
}

// ignore: must_be_immutable
class ItemAddedCartEvent extends ShopEvent {
  List<Product> cartItems;

  ItemAddedCartEvent({required this.cartItems});
}

// ignore: must_be_immutable
class ItemDeleteCartEvent extends ShopEvent {
  List<Product> cartItems;
  int index;
  ItemDeleteCartEvent({required this.cartItems, required this.index});
}
