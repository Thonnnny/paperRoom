import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freshbuyer/bloc/cart/bloc/cart_event.dart';
import 'package:freshbuyer/model/productCartResponse.dart';
import 'package:meta/meta.dart';

import '../../../model/productElement.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  @override
  CartState get initialState => CartEmpty();

  CartBloc() : super(CartEmpty()) {
    on<AddProduct>((event, emit) {
      if (state is CartLoaded) {
        final List<Product> newProducts =
            List.from((state as CartLoaded).products)..add(event.product);
        emit(CartLoaded(newProducts));
      } else {
        final List<Product> newProducts = [event.product];
        emit(CartLoaded(newProducts));
      }
    });

    on<RemoveProduct>((event, emit) {
      if (state is CartLoaded) {
        final List<Product> newProducts =
            List.from((state as CartLoaded).products)..remove(event.product);
        emit(CartLoaded(newProducts));
      }
    });

    on<ClearCart>((event, emit) {
      emit(CartEmpty());
    });
  }

  //@override
  // Stream<CartState> mapEventToState(CartEvent event) async* {
  //   if (event is AddProduct) {
  //     if (state is CartLoaded) {
  //       final List<Product> newProducts =
  //           List.from((state as CartLoaded).products)..add(event.product);
  //       yield CartLoaded(newProducts);
  //     } else {
  //       final List<Product> newProducts = [event.product];
  //       yield CartLoaded(newProducts);
  //     }
  //   } else if (event is RemoveProduct) {
  //     if (state is CartLoaded) {
  //       final List<Product> newProducts =
  //           List.from((state as CartLoaded).products)..remove(event.product);
  //       yield CartLoaded(newProducts);
  //     }
  //   }
  // }
}
