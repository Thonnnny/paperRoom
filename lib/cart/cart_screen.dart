import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:freshbuyer/class/classCart.dart';
import 'package:freshbuyer/class/classCustomer.dart';
import 'package:freshbuyer/components/productsInCart.dart';
import 'package:freshbuyer/constants.dart';
import 'package:freshbuyer/model/cartResponses.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../class/classOnlyDetailsCart.dart';
import '../components/app_button.dart';
import '../components/app_text.dart';

import '../components/splashorders_Screen.dart';
import '../model/customerResponse.dart';
import '../model/productCartResponse.dart';
import '../providers/orders_provider.dart';
import '../screens/tabbar/tabbar.dart';
import '../size_config.dart';

class CartScreen extends StatefulWidget {
  final List<CartClass> product;

  const CartScreen({super.key, required this.product});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Color borderColor = const Color(0xffE2E2E2);
  double borderRadius = 18;
  int amount = 1;

  late Future<List<dynamic>> _products;
  late Future<Customer> _customer;
  late Future<CartClass> _cart;
  CustomerCar customerClass = CustomerCar();
  ProductsCar apisClass = ProductsCar();
  CartOnlyObjectCar cartClass = CartOnlyObjectCar();

  TextEditingController notaAdicional = TextEditingController();
  TextEditingController telefono = TextEditingController();
  TextEditingController direccion = TextEditingController();

  @override
  void initState() {
    super.initState();
    _customer = customerClass.getCustomerCart();
    _products = apisClass.getCartProducts();
    _cart = cartClass.getOnlyObjectCart();
    notaAdicional = TextEditingController();
    telefono = TextEditingController();
    direccion = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
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
                    expandedHeight: getProportionateScreenHeight(428),
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
                          child:
                              Lottie.asset('assets/images/prepareOrder.json')),
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
                          const SizedBox(height: 8),
                          customerInfo(context),
                          const SizedBox(height: 16),
                          _buildLine(),
                          const SizedBox(height: 16),
                          ..._buildPhone(),
                          const SizedBox(height: 8),
                          _crearTelefono(),
                          const SizedBox(height: 16),
                          _buildLine(),
                          const SizedBox(height: 8),
                          ..._buildDirection(),
                          const SizedBox(height: 8),
                          _crearDireccion(),
                          const SizedBox(height: 16),
                          _buildLine(),
                          const SizedBox(height: 8),
                          ..._buildDescription(),
                          const SizedBox(height: 8),
                          _crearNotaAdicional(),
                          const SizedBox(height: 16),
                          _buildLine(),
                          const SizedBox(height: 8),
                          ..._buildCartTitle(),
                          const SizedBox(height: 16),
                          myProductListCart(context),
                          const SizedBox(height: 16),
                          const SizedBox(height: 115),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              _buldFloatBar()
            ],
          ),
        ),
      ),
    );
  }

  Widget _crearTelefono() {
    final ordersForm = Provider.of<OrderFormProvider>(context);
    return Container(
      child: TextFormField(
        autocorrect: false,
        keyboardType: TextInputType.phone,
        onChanged: (value) => ordersForm.telefono = value,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor ingrese su telefono';
          }
          if (value.length > 8) {
            return 'Por favor ingrese un telefono valido';
          } else {
            return 'se necesita un telefono valido';
          }
        },
        style: const TextStyle(
            color: color2,
            fontSize: 18,
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.bold),
        controller: telefono,
        //cursorColor: firstColor,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: color5, width: 1.0),
              borderRadius: BorderRadius.circular(20)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: color5, width: 1.0),
              borderRadius: BorderRadius.circular(20)),
          prefixIcon: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.phone,
              color: color5,
              size: 30,
            ),
          ),
          hintText: "Teléfono",
          hintStyle: const TextStyle(
              color: color2,
              fontSize: 15,
              fontWeight: FontWeight.bold,
              fontFamily: 'Urbanist'),
          border: InputBorder.none,
        ),
      ),
    );
  }

  List<Widget> _buildDirection() {
    return [
      const Text('Dirección:',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: color5)),
      const SizedBox(height: 8),
      const Text(
        'Agrega una dirección de entrega:',
        // '${widget.product.description}',
        style: TextStyle(
            fontSize: 14,
            color: color2,
            fontWeight: FontWeight.w500,
            fontFamily: 'Urbanist'),
      ),
    ];
  }

  Widget _crearDireccion() {
    final ordersForm = Provider.of<OrderFormProvider>(context);
    return Container(
      child: TextFormField(
        autocorrect: false,
        keyboardType: TextInputType.text,
        onChanged: (value) => ordersForm.direccion = value,
        validator: (value) => value == null || value.isEmpty
            ? 'El campo no puede estar vacio'
            : null,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: 'Urbanist',
        ),
        controller: direccion,
        //cursorColor: firstColor,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: color5, width: 1.0),
              borderRadius: BorderRadius.circular(20)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: color5, width: 1.0),
              borderRadius: BorderRadius.circular(20)),
          prefixIcon: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.location_on,
              color: color5,
              size: 30,
            ),
          ),
          hintText: "Dirección",
          hintStyle: const TextStyle(
              color: color2,
              fontSize: 15,
              fontWeight: FontWeight.bold,
              fontFamily: 'Urbanist'),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _crearNotaAdicional() {
    final ordersForm = Provider.of<OrderFormProvider>(context);
    return Container(
      child: TextFormField(
        autocorrect: false,
        keyboardType: TextInputType.text,
        onChanged: (value) => ordersForm.nombreCliente = value,
        validator: (value) => value == null || value.isEmpty
            ? 'El campo no puede estar vacio'
            : null,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: 'Urbanist',
        ),
        controller: notaAdicional,
        //cursorColor: firstColor,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: color5, width: 1.0),
              borderRadius: BorderRadius.circular(20)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: color5, width: 1.0),
              borderRadius: BorderRadius.circular(20)),
          prefixIcon: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.note_alt_outlined,
              color: color5,
              size: 30,
            ),
          ),
          hintText: "Nota adicional",
          hintStyle: const TextStyle(
              color: color2,
              fontSize: 15,
              fontWeight: FontWeight.bold,
              fontFamily: 'Urbanist'),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buldFloatBar() {
    buildAddCard() => Container(
          height: 58,
          width: getProportionateScreenWidth(258),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(29)),
            color: Colors.green[500],
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CartScreen(
                      product: [],
                    ),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/icons/detail/bag@2x.png', scale: 1.5),
                  const SizedBox(width: 16),
                  const Text(
                    'Realizar Pedido',
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
                        style: TextStyle(
                            color: color2,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    totalInfo(),
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

  Widget totalInfo() {
    return FutureBuilder<CartClass>(
      future: _cart,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var total = snapshot.data!.total;
          if (total == null) {
            return const AppText(
              text: "\$0",
              fontSize: 18,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.right,
              color: color6,
            );
          }
          return AppText(
            text: "\$${snapshot.data!.total.toString()}",
            fontSize: 18,
            fontWeight: FontWeight.w500,
            textAlign: TextAlign.right,
            color: color6,
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return const CircularProgressIndicator();
      },
    );
  }

  Widget _buildLine() {
    return Container(height: 1, color: color5);
  }

  List<Widget> _buildTitle() {
    var size = MediaQuery.of(context).size;
    return <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: size.width * 0.75,
            child: const Center(
              child: Text(
                'Detalles de la orden',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 32, color: color2),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: color5, size: 30),
            onPressed: () {},
          ),
        ],
      ),
    ];
  }

  List<Widget> _buildDescription() {
    return [
      const Text('Descripción',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: color5)),
      const SizedBox(height: 8),
      const Text(
        'Agrega una descripción adicional a tu pedido:',
        // '${widget.product.description}',
        style: TextStyle(
            fontSize: 14,
            color: color2,
            fontWeight: FontWeight.w500,
            fontFamily: 'Urbanist'),
      ),
    ];
  }

  List<Widget> _buildPhone() {
    return [
      const Text('Número de teléfono',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: color5)),
      const SizedBox(height: 8),
      const Text(
        'Agrega un teléfono para contactarte:',
        // '${widget.product.description}',
        style: TextStyle(
            fontSize: 14,
            color: color2,
            fontWeight: FontWeight.w500,
            fontFamily: 'Urbanist'),
      ),
    ];
  }

  List<Widget> _buildCartTitle() {
    return [
      const Text('Productos en el carrito',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: color5)),
      const SizedBox(height: 8),
      const Text(
        'Estos son tus productos agregados:',
        // '${widget.product.description}',
        style: TextStyle(
            fontSize: 14,
            color: color2,
            fontWeight: FontWeight.w500,
            fontFamily: 'Urbanist'),
      ),
    ];
  }

  Widget customerInfo(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return FutureBuilder<Customer>(
      future: _customer,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: 1,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              //Item cart = snapshot.data![index];
              var name = snapshot.data?.fullname;
              if (name == null) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Text('Nombre de Usuario',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: color5)),
                    const Text('No hay datos de usuario',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: color2)),
                  ],
                );
              }
              return Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Nombre de Usuario',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: color5)),
                      Container(
                        child: Text(
                          "$name",
                          textAlign: TextAlign.left,
                          softWrap: true,
                          style: const TextStyle(
                              fontSize: 14,
                              color: color2,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Urbanist'),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return const CircularProgressIndicator();
      },
    );
  }

  Widget myProductListCart(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return FutureBuilder<List<dynamic>>(
      future: _products,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  itemCount: snapshot.data!.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    Item cart = snapshot.data![index];
                    // ignore: unnecessary_null_comparison
                    if (cart == null) {
                      return const Text(
                          'No puedes realizar un pedido vacío, inicia sesión y agrega productos a tu carrito',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: color2));
                    }
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 10,
                      color: color2,
                      child: GestureDetector(
                          child: Stack(
                            children: <Widget>[
                              ProductInCardOrder(
                                data: cart,
                              )
                            ],
                          ),
                          onTap: () {}),
                    );
                  },
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return const CircularProgressIndicator();
      },
    );
  }

  Widget getCheckoutButton(BuildContext context, int index) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      child: AppButton(
        roundness: 25,
        label: "Hacer pedido",
        fontWeight: FontWeight.w600,
        padding: const EdgeInsets.symmetric(vertical: 30),
        //trailingWidget: getButtonPriceWidget(),
        onPressed: () {
          showBottomSheet(context);
        },
      ),
    );
  }

  // Widget getButtonPriceWidget() {
  //   return Container(
  //     padding: const EdgeInsets.all(2),
  //     decoration: BoxDecoration(
  //       color: const Color(0xff489E67),
  //       borderRadius: BorderRadius.circular(4),
  //     ),
  //     child: Text(
  //       widget.totalPrice.toString(),
  //       style: const TextStyle(fontWeight: FontWeight.w600),
  //     ),
  //   );
  // }

  void showBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return const SplashOrdersScreen();
        });
  }
}
