import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../model/productElement.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<AddToCart>((event, emit) {
      emit(CartAdded(event.product));
      // _productItems.add(event.productIndex);
      // emit(CartAdded(newProduct: _productItems));
    });

    // on<RemoveFromCart>((event, emit) {
    //   _productItems.remove(event.productIndex);
    //   emit(CartRemoved(product: _productItems));
    // });
  }

  // final List<Product> _productItems = [];
  // List<Product> get items => _productItems;
}
