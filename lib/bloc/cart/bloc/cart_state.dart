part of 'cart_bloc.dart';

// @immutable
// abstract class CartState {
//   final bool existCart;
//   final List<Product>? product;

//   const CartState({this.existCart = false, this.product});
//   List<Product> get props => [];
// }

// class CartInitial extends CartState {
//   const CartInitial() : super(existCart: false);
// }

// class CartLoadInProgress extends CartState {}

// class CartAdded extends CartState {
//   final List<Product> newProduct;
//   const CartAdded(this.newProduct)
//       : super(existCart: true, product: newProduct);

//   @override
//   String toString() => 'ProductAdded { todos: $newProduct }';
// }

// class CartRemoved extends CartState {
//   @override
//   final List<Product> product;
//   const CartRemoved(this.product) : super(existCart: true, product: product);

//   @override
//   String toString() => 'ProductRemoved { todos: $product }';
// }

abstract class CartState {}

class CartEmpty extends CartState {}

class CartLoaded extends CartState {
  final List<Product> products;
  CartLoaded(this.products);
}

class TotalPrice extends CartState {
  final double totalPrice;
  TotalPrice(this.totalPrice);
}
