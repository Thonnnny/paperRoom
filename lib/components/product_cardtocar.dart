import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freshbuyer/model/productElement.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../bloc/cart/bloc/cart_bloc.dart';
import '../bloc/cart/bloc/cart_event.dart';
import '../constants.dart';

typedef ProductCardOnTaped = void Function(Product data);

bool _iscollected = false;

class ProductCardtoCar extends StatefulWidget {
  const ProductCardtoCar({super.key, required this.data, this.ontap});

  final Product data;
  final ProductCardOnTaped? ontap;

  @override
  State<ProductCardtoCar> createState() => _ProductCardtoCarState();
}

class _ProductCardtoCarState extends State<ProductCardtoCar> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    const borderRadius = BorderRadius.all(Radius.circular(20));
    return InkWell(
      hoverColor: color4,
      borderRadius: borderRadius,
      onTap: () {},
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: borderRadius,
                color: color5,
              ),
              child: Stack(
                children: [
                  Image.network(widget.data.mainImage,
                      width: 250, height: 250, fit: BoxFit.cover),
                  Positioned(
                    child: IconButton(
                      onPressed: () =>
                          setState(() => _iscollected = !_iscollected),
                      icon: Image.asset(
                          'assets/icons/${_iscollected ? 'bold' : 'light'}/heart@2x.png',
                          color: color6),
                      iconSize: 28,
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            width: size.width,
            child: Column(
              children: [
                Text(
                  widget.data.name.split('').first.toUpperCase() +
                      widget.data.name.split('').sublist(1).join(''),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: color6,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    widget.data.description.split('').first.toUpperCase() +
                        widget.data.description.split('').sublist(1).join(''),
                    style: const TextStyle(
                      color: color3,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  '\$${widget.data.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold, color: color3),
                ),
                Text(
                  '\$${widget.data.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                      decoration: TextDecoration.lineThrough,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: color2),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: color5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      BlocProvider.of<CartBloc>(context)
                          .add(AddProduct(widget.data));
                      QuickAlert.show(
                        context: context,
                        title: 'Éxito',
                        type: QuickAlertType.success,
                        confirmBtnColor: Colors.green,
                        confirmBtnText: 'Ok',
                        text: 'Producto agregado!',
                      );
                    },
                    child: const Text(
                      'Agregar al carrito',
                      style: TextStyle(color: color3),
                    )),
                const SizedBox(height: 20),
                const Divider(
                  color: color5,
                  thickness: 2,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
