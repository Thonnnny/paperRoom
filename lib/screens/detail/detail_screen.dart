import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freshbuyer/components/loaderImage.dart';
import 'package:freshbuyer/components/splashorders_Screen.dart';
import 'package:freshbuyer/model/cartResponses.dart';
import 'package:freshbuyer/screens/auth/login.dart';
import 'package:freshbuyer/size_config.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../cart/cart_screen.dart';
import '../../components/app_text.dart';
import '../../constants.dart';
import '../../helpers/base_client.dart';
import '../../helpers/res_apis.dart';
import '../../model/productElement.dart';
import '../tabbar/tabbar.dart';

// ignore: must_be_immutable
class ShopDetailScreen extends StatefulWidget {
  const ShopDetailScreen({
    super.key,
    required this.product,
  });
  final Product product;

  // ignore: prefer_typing_uninitialized_variables

  @override
  State<ShopDetailScreen> createState() => _ShopDetailScreenState();
}

class _ShopDetailScreenState extends State<ShopDetailScreen> {
  int _quantity = 0;
  int index = 0;
  bool _iscollected = false;

  Future<Cart> getCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('accesstoken');
    var response = await BaseClient().get(RestApis.getCart,
        {"Content-Type": "application/json", "accesstoken": token});
    print('This is the response from the cart screen');
    print(response);
    var rsp = jsonDecode(response);
    if (rsp['type'] == 'success') {
      Cart cart = Cart.fromJson(rsp);
      return cart;
    } else {
      print('No hay productos en el carrito');
      return Cart();
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: color3,
          child: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    expandedHeight: size.height * 0.4,
                    leadingWidth: size.width * 0.2,
                    leading: IconButton(
                      icon: Image.asset(
                        'assets/icons/back@2x.png',
                        scale: 1,
                        color: color6,
                      ),
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const FRTabbarScreen()),
                            (Route<dynamic> route) => false);
                      },
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                          color: color4,
                          child: ImageLoader(
                              imageUrl: '${widget.product.mainImage}')),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ..._buildTitle(),
                          const SizedBox(height: 16),
                          _buildLine(),
                          const SizedBox(height: 16),
                          ..._buildDescription(),
                          const SizedBox(height: 16),
                          _buildLine(),
                          const SizedBox(height: 16),
                          ..._buildPrice(),
                          const SizedBox(height: 16),
                          _buildLine(),
                          const SizedBox(height: 16),
                          _buildQuantity(),
                          const SizedBox(height: 115),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              _buldFloatBar(widget.product),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTitle() {
    var size = MediaQuery.of(context).size;
    return <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: size.width * 0.6,
            child: Center(
              child: Text(
                '${widget.product.name}',
                textAlign: TextAlign.left,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 25, color: color2),
              ),
            ),
          ),
          IconButton(
            onPressed: () => setState(() => _iscollected = !_iscollected),
            icon: Image.asset(
              'assets/icons/${_iscollected ? 'bold' : 'light'}/heart@2x.png',
              color: color4,
            ),
            iconSize: 28,
          ),
        ],
      ),
      const SizedBox(height: 12),
      Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              color: color4,
            ),
            child: const Text(
              '9,742 sold',
              style: TextStyle(
                  fontSize: 10, fontWeight: FontWeight.w500, color: color3),
            ),
          ),
          const SizedBox(width: 16),
          Image.asset(
            'assets/icons/start@2x.png',
            height: 20,
            width: 20,
            color: color6,
          ),
          const SizedBox(width: 8),
          const Text(
            '4.8 (6,573 reviews)',
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: color5),
          ),
        ],
      ),
    ];
  }

  Widget _buildLine() {
    return Container(height: 1, color: color5);
  }

  List<Widget> _buildDescription() {
    return [
      const Text('Descripción',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: color5)),
      const SizedBox(height: 8),
      Text(
        '${widget.product.description}',
        style: const TextStyle(
            fontSize: 14,
            color: color2,
            fontWeight: FontWeight.w500,
            fontFamily: 'Urbanist'),
      ),
    ];
  }

  List<Widget> _buildPrice() {
    return [
      const Text('Precio por unidad',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: color5)),
      const SizedBox(height: 8),
      Text(
        '\$${widget.product.price.toString()}',
        style: const TextStyle(
            fontSize: 18, color: color2, fontWeight: FontWeight.bold),
      ),
    ];
  }

  Widget _buildQuantity() {
    return Row(
      children: [
        const Text('Cantidad',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, color: color5)),
        const SizedBox(width: 20),
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(24)),
            color: color4,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Material(
            color: Colors.transparent,
            child: Row(
              children: [
                InkWell(
                  child: Image.asset(
                    'assets/icons/detail/minus@2x.png',
                    scale: 2,
                    color: color6,
                  ),
                  onTap: () {
                    if (_quantity <= 0) return;
                    setState(() => _quantity -= 1);
                  },
                ),
                const SizedBox(width: 20),
                Text('$_quantity',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: color3)),
                const SizedBox(width: 20),
                InkWell(
                  child: Image.asset(
                    'assets/icons/detail/plus@2x.png',
                    scale: 2,
                    color: color6,
                  ),
                  onTap: () => setState(() => _quantity += 1),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  int getPrice() {
    return widget.product.price * _quantity;
  }

  Widget _buldFloatBar(Product product) {
    buildAddCard() => Container(
          height: 58,
          width: 220,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(29)),
            color: color5,
            boxShadow: [
              BoxShadow(
                offset: const Offset(4, 8),
                blurRadius: 20,
                color: const Color(0xFF101010).withOpacity(0.25),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              highlightColor: color6,
              splashColor: color6,
              borderRadius: const BorderRadius.all(Radius.circular(29)),
              // splashColor: const Color(0xFFEEEEEE),
              onTap: () {
                addProductToCart(product);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/icons/detail/bag@2x.png', scale: 1.5),
                  const SizedBox(width: 16),
                  const Text(
                    'Agregar producto',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: color2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        color: color3,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            _buildLine(),
            const SizedBox(height: 21),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Precio Total',
                        style: TextStyle(color: color2, fontSize: 15)),
                    SizedBox(height: 6),
                    AppText(
                      text: "\$${getPrice().toStringAsFixed(2)}",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.right,
                      color: color6,
                    ),
                  ],
                ),
                buildAddCard()
              ],
            ),
            const SizedBox(height: 36),
          ],
        ),
      ),
    );
  }

  void addProductToCart(Product product) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('accesstoken');
      if (token == null) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Error',
          text:
              'No se pudo agregar el producto debido a que no se ha iniciado sesión',
          confirmBtnColor: Colors.red,
          confirmBtnText: 'Aceptar',
          onConfirmBtnTap: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        const SafeArea(child: LoginScreen())),
                (Route<dynamic> route) => false);
          },
        );
      } else {
        Map data = {
          'productId': product.id,
          'quantity': _quantity,
        };
        print('This is your data: $data');
        var response = await BaseClient().post(RestApis.apiAddProductToOrder,
            data, {"Content-Type": "application/json", "accesstoken": token});
        print(response);
        var rsp = jsonDecode(response);
        if (rsp['type'] == 'success') {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            title: 'Exito',
            text: '${rsp['message']}',
            confirmBtnColor: Colors.green,
            confirmBtnText: 'Aceptar',
            onConfirmBtnTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const SafeArea(child: SplashOrdersScreen())),
                  (Route<dynamic> route) => false);
            },
          );
        } else {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'Error',
            text: '${rsp['message']}',
            confirmBtnColor: Colors.red,
            confirmBtnText: 'Aceptar',
            onConfirmBtnTap: () {
              Navigator.pop(context);
            },
          );
        }
      }
    } on Exception catch (e) {
      print('Error: ');
      print(e);
    }
  }
}
