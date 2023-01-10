part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class AddToCart extends CartEvent {
  final Product product;

  AddToCart(this.product);
  @override
  List<Object> get props => [product];

  @override
  String toString() => 'AddProduct { index: $product }';
}

class RemoveFromCart extends CartEvent {
  final List<Product> product;

  RemoveFromCart(this.product);
  @override
  List<Object> get props => [product];

  @override
  String toString() => 'RemoveProduct { index: $product }';
}
