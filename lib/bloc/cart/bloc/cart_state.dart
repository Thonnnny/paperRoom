part of 'cart_bloc.dart';

@immutable
abstract class CartState {
  final bool existCart;
  final Product? product;

  const CartState({this.existCart = false, this.product});
  List<Object> get props => [];
}

class CartInitial extends CartState {
  const CartInitial() : super(existCart: false);
}

class CartLoadInProgress extends CartState {}

class CartAdded extends CartState {
  final Product newProduct;
  const CartAdded(this.newProduct)
      : super(existCart: true, product: newProduct);
  @override
  List<Object> get props => [newProduct];

  @override
  String toString() => 'ProductAdded { todos: $newProduct }';
}

class CartRemoved extends CartState {
  @override
  final Product product;
  const CartRemoved(this.product) : super(existCart: true, product: product);
  @override
  List<Object> get props => [product];

  @override
  String toString() => 'ProductRemoved { todos: $product }';
}
