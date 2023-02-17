import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freshbuyer/model/cartResponses.dart';
import 'package:freshbuyer/model/productCartResponse.dart';
import 'package:freshbuyer/model/productElement.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../helpers/base_client.dart';
import '../helpers/res_apis.dart';
import '../screens/detail/detail_screen.dart';

typedef ProductinCardOnTaped = void Function(Product data);

bool _iscollected = false;

class ProductInCardOrder extends StatefulWidget {
  const ProductInCardOrder({super.key, required this.data, this.ontap});

  final Item data;
  final ProductinCardOnTaped? ontap;

  @override
  State<ProductInCardOrder> createState() => _ProductInCardOrderState();
}

class _ProductInCardOrderState extends State<ProductInCardOrder> {
  void removeProductFromCart(Item data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('accesstoken');
    var idProduct = data.id;
    print(token);
    print('This is your $idProduct to remove of cart');
    var response = await BaseClient().post(
        RestApis.apiRemoveProductFromOrder,
        {"Content-Type": "application/json", "accesstoken": token},
        {"id": idProduct});
    var rsp = jsonDecode(response);
    print('this is your response of remove product $rsp');
    if (rsp['type'] == "success") {
      print('remove product successful');
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: 'Cerrando sesión',
        text: '${rsp['message']}',
        confirmBtnColor: Colors.green,
        confirmBtnText: 'Continuar',
      );
      Navigator.pushReplacementNamed(context, '/cart');
    } else {
      print('remove product failed');
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: '${rsp['message']}',
        confirmBtnColor: Colors.red,
        confirmBtnText: 'Reintentar',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    const borderRadius = BorderRadius.all(Radius.circular(20));
    return InkWell(
      hoverColor: color1,
      borderRadius: borderRadius,
      onTap: () {},
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: borderRadius,
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: size.height * 0.15,
                    width: size.width * 0.3,
                    decoration: BoxDecoration(
                        color: color5, //PARA PROBAR CONTAINER
                        borderRadius: BorderRadius.circular(15.0),
                        image: DecorationImage(
                          image: NetworkImage(
                            "${widget.data.mainImage}",
                          ),
                          fit: BoxFit.cover,
                        ),
                        // ignore: prefer_const_literals_to_create_immutables
                        boxShadow: [
                          const BoxShadow(
                            //SOMBRA
                            color: Color(0xffA4A4A4),
                            offset: Offset(1.0, 5.0),
                            blurRadius: 3.0,
                          ),
                        ]),
                  ),
                ),
                Positioned(
                  child: IconButton(
                    icon: const Icon(Icons.delete, color: color6, size: 30),
                    onPressed: () {
                      removeProductFromCart(widget.data);
                    },
                  ),
                )
              ],
            ),
          ),
          Container(
            width: size.width * 0.4,
            child: Column(
              children: [
                const SizedBox(height: 12),
                Container(
                  width: size.width,
                  height: size.height * 0.085,
                  child: Text(
                    '${widget.data.productName!.split('').first.toUpperCase() + widget.data.productName!.split('').sublist(1).join('')}',
                    //overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: color3,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Text(
                      textAlign: TextAlign.right,
                      "Cantidad:",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: color6,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      textAlign: TextAlign.right,
                      "${widget.data.quantity}",
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: color6,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Precio:',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: color3),
                    ),
                    Text(
                      '\$${widget.data.productBilledPrice}',
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: color3),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSoldPoint(double star, int sold) {
    return Row(
      children: [
        Image.asset('assets/icons/start@2x.png',
            width: 20, height: 20, color: color6),
        const SizedBox(width: 8),
        Text(
          '$star',
          style: const TextStyle(
            color: color3,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 8),
        const Text(
          '|',
          style: TextStyle(
              fontWeight: FontWeight.w500, color: color6, fontSize: 14),
        ),
        const SizedBox(width: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(6)),
            color: color2.withOpacity(0.5),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Text(
            '$sold Vendidos',
            style: const TextStyle(
              color: Color(0xFF35383F),
              fontWeight: FontWeight.w500,
              fontSize: 10,
            ),
          ),
        ),
      ],
    );
  }
}
