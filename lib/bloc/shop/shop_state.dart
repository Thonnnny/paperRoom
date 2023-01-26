part of 'shop_bloc.dart';

abstract class ShopState extends Equatable {
  const ShopState();

  @override
  List<Object> get props => [];
}

class ShopInitial extends ShopState {}

// ignore: must_be_immutable
class ShopPageLoadedState extends ShopState {
  ShopData shopData;
  ShopData cartData;

  ShopPageLoadedState({required this.cartData, required this.shopData});
}

// ignore: must_be_immutable
class ItemAddingCartState extends ShopState {
  ShopData? cartData;
  List<Product> cartItems;

  ItemAddingCartState({this.cartData, required this.cartItems});
}

// ignore: must_be_immutable
class ItemAddedCartState extends ShopState {
  List<Product> cartItems;

  ItemAddedCartState({required this.cartItems});
}

// ignore: must_be_immutable
class ItemDeletingCartState extends ShopState {
  List<Product> cartItems;

  ItemDeletingCartState({required this.cartItems});
}
