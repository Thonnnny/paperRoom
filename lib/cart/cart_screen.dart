import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freshbuyer/components/productsInCart.dart';
import 'package:freshbuyer/constants.dart';
import 'package:freshbuyer/screens/auth/login.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/app_button.dart';
import '../components/app_text.dart';

import '../components/splashorders_Screen.dart';
import '../helpers/base_client.dart';
import '../helpers/res_apis.dart';
import '../providers/orders_provider.dart';
import '../screens/tabbar/tabbar.dart';
import '../screens/test/waitingOrders.dart';
import '../size_config.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Color borderColor = const Color(0xffE2E2E2);
  double borderRadius = 18;
  int amount = 1;

  // CustomerCar customerClass = CustomerCar();
  // ProductsCar apisClass = ProductsCar();
  // CartOnlyObjectCar cartClass = CartOnlyObjectCar();

  String _countrySelected = '';
  String _citySelected = '';
  String _subdivisionSelected = '';

  List<dynamic> countryList = [];
  List<dynamic> subdivisionList = [];
  List<dynamic> cityList = [];

  dynamic customerName = '';
  dynamic actualStatus = '';
  dynamic paymentStatus = '';
  dynamic totalPrice = '';
  Map<dynamic, dynamic> cartList = {};
  List<dynamic> itemsList = [];

  late final List<String> _paymentMethods = ['cash', 'transfer'];
  late String _paymentSelected = 'cash';

  TextEditingController notaAdicional = TextEditingController();

  void createOrder(String reference, String city, String subdivision,
      String country, String paymentMethod) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('accesstoken');
      if (token == null || token.isEmpty) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Error',
          text: 'Necesitas iniciar sesión para realizar esta acción',
          confirmBtnColor: Colors.red,
          confirmBtnText: 'Continuar',
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
          'reference': reference,
          'city': city,
          'subdivision': subdivision,
          'country': country,
          'paymentMethod': paymentMethod,
        };
        if (city.isEmpty ||
            subdivision.isEmpty ||
            country.isEmpty ||
            paymentMethod.isEmpty) {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'Error',
            text: 'Necesitas llenar todos los campos',
            confirmBtnColor: Colors.red,
            confirmBtnText: 'Continuar',
            onConfirmBtnTap: () {
              Navigator.of(context).pop();
            },
          );
        } else {
          print('This is your data to create order $data');
          var response = await BaseClient().post(RestApis.apiCreateOrder, data,
              {"Content-Type": "application/json", "accesstoken": token});
          if (response != null) {
            print(response);
            var rsp = jsonDecode(response);
            print('This is your confirm Order response *****$rsp');
            if (rsp['type'] == 'success') {
              QuickAlert.show(
                context: context,
                type: QuickAlertType.success,
                title: '${rsp['title']}',
                text: '${rsp['message']}',
                confirmBtnColor: Colors.green,
                confirmBtnText: 'Continuar',
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
                title: 'Oops...',
                text: '${rsp['message']}',
                confirmBtnColor: Colors.red,
                confirmBtnText: 'Reintentar',
              );
            }
          } else {
            print('This is the response of create order $response');
          }
        }
      }
    } on Exception catch (e) {
      print('Error: ');
      print(e);
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: '$e',
        confirmBtnColor: Colors.red,
        confirmBtnText: 'Reintentar',
      );
    }
  }

  Future<List<dynamic>> _loadCountries() async {
    try {
      var response = await BaseClient()
          .get(RestApis.getCountry, {"Content-Type": "application/json"});
      print('This is the response of country$response');
      var rsp = jsonDecode(response);
      if (rsp['type'] == 'success') {
        setState(() {
          countryList = rsp['countries'];
          print('This is the country list $countryList');
        });
        return countryList;
      }
      return countryList;
    } catch (e) {
      print('This is the error $e');
    }
    return countryList;
  }

  Future<List<dynamic>> _loadSubdivision() async {
    var response = await BaseClient().get(
        RestApis.getSubdivision + _countrySelected,
        {"Content-Type": "application/json"});
    var rsp = jsonDecode(response);
    if (rsp['type'] == 'success') {
      setState(() {
        subdivisionList = rsp['subdivisions'];
        print('This is the subdivision list $subdivisionList');
      });
      return subdivisionList;
    }
    return subdivisionList;
  }

  Future<List<dynamic>> _loadCities() async {
    var response = await BaseClient().get(
        RestApis.getCities + _subdivisionSelected,
        {"Content-Type": "application/json"});
    var rsp = jsonDecode(response);
    if (rsp['type'] == 'success') {
      setState(() {
        cityList = rsp['cities'];
        print('This is the city list $cityList');
      });
      return cityList;
    }
    return cityList;
  }

  Future<List<dynamic>> getCartInfo() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('accesstoken');
      if (token!.isEmpty) {
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const WaitingOrder()),
            (route) => false);
      }
      var response = await BaseClient().get(RestApis.getCart,
          {"Content-Type": "application/json", "accesstoken": token});
      var rsp = jsonDecode(response);
      if (rsp['type'] == 'success') {
        setState(() {
          customerName = rsp['cart']['customer']['fullname'];
          actualStatus = rsp['actualStatus'];
          totalPrice = rsp['cart']['total'];
          paymentStatus = rsp['cart']['paymentStatus'];
          cartList = rsp['cart'];
          itemsList = rsp['cart']['items'];
          print('This is the cart list $cartList');
          print('This is the items list $itemsList');
          print('This is the customer name $customerName');
          print('This is the actual status $actualStatus');
          print('This is the total price $totalPrice');
        });
        return itemsList;
      } else {
        return itemsList;
      }
    } catch (e) {
      print('This is the error from the getCartInfo function $e');
    }
    return itemsList;
  }

  @override
  void initState() {
    super.initState();
    _loadCountries();
    notaAdicional = TextEditingController();
    getCartInfo();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    if (cartList.isEmpty) {
      return WaitingOrder();
    } else {
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
                      expandedHeight: size.height,
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
                            child: Lottie.asset(
                                'assets/images/prepareOrder.json')),
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
                            ..._buildPayment(),
                            const SizedBox(height: 8),
                            _crearMetodoDePago(),
                            const SizedBox(height: 16),
                            _buildLine(),
                            const SizedBox(height: 16),
                            ..._buildDirection(),
                            const SizedBox(height: 16),
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
  }

  Widget _crearDireccion() {
    var size = MediaQuery.of(context).size;
    if (countryList.length == 1) {
      print('This is the countryListValue$countryList');
      return Container(
        width: size.width * 0.9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: DropdownButtonFormField(
                icon: const Icon(Icons.arrow_drop_down, color: color5),
                iconSize: 24,
                dropdownColor: color5,
                elevation: 16,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: color5, width: 1.0),
                      borderRadius: BorderRadius.circular(20)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: color5, width: 1.0),
                      borderRadius: BorderRadius.circular(20)),
                  hintText: 'Selecciona un País:',
                  hintStyle: const TextStyle(
                      color: color2,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Urbanist'),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                ),
                items: countryList.map((country) {
                  return DropdownMenuItem(
                    value: country['_id'],
                    child: Text(country['name'],
                        style: const TextStyle(
                            color: color2,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _countrySelected = value.toString();
                    _subdivisionSelected = '';
                    _citySelected = '';
                    subdivisionList = [];
                    cityList = [];
                  });
                  _loadSubdivision().then((value) {
                    setState(() {
                      subdivisionList = value;
                    });
                  });
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: size.width * 0.9,
              child: DropdownButtonFormField(
                icon: const Icon(Icons.arrow_drop_down, color: color5),
                iconSize: 24,
                dropdownColor: color5,
                elevation: 16,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: color5, width: 1.0),
                      borderRadius: BorderRadius.circular(20)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: color5, width: 1.0),
                      borderRadius: BorderRadius.circular(20)),
                  hintText: 'Selecciona un Departamento:',
                  hintStyle: const TextStyle(
                      color: color2,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Urbanist'),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                ),
                items: subdivisionList.map((subdivision) {
                  return DropdownMenuItem(
                    value: subdivision['_id'],
                    child: Text(subdivision['name'],
                        style: const TextStyle(
                            color: color2,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _subdivisionSelected = value.toString();
                    _citySelected = '';
                    cityList = [];
                    _loadCities().then((value) {
                      setState(() {
                        cityList = value;
                        print('This is the new elements of cityList$cityList');
                      });
                    });
                  });
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: size.width * 0.9,
              child: DropdownButtonFormField(
                icon: const Icon(Icons.arrow_drop_down, color: color5),
                iconSize: 24,
                dropdownColor: color5,
                elevation: 16,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: color5, width: 1.0),
                      borderRadius: BorderRadius.circular(20)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: color5, width: 1.0),
                      borderRadius: BorderRadius.circular(20)),
                  hintText: 'Selecciona una Ciudad:',
                  hintStyle: const TextStyle(
                      color: color2,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Urbanist'),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                ),
                value: _citySelected == '' ? null : _citySelected,
                items: cityList.map((city) {
                  return DropdownMenuItem(
                    value: city['_id'],
                    child: Text(city['name'],
                        style: const TextStyle(
                            color: color2,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _citySelected = value.toString();
                  });
                },
              ),
            ),
          ],
        ),
      );
    }
    return Container(
      width: size.width * 0.9,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: DropdownButtonFormField(
              icon: const Icon(Icons.arrow_drop_down, color: color5),
              iconSize: 24,
              dropdownColor: color5,
              elevation: 16,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: color5, width: 1.0),
                    borderRadius: BorderRadius.circular(20)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: color5, width: 1.0),
                    borderRadius: BorderRadius.circular(20)),
                hintText: 'País',
                hintStyle: const TextStyle(
                    color: color2,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Urbanist'),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              ),
              items: countryList.map((country) {
                return DropdownMenuItem(
                  value: country['_id'],
                  child: Text(country['name'],
                      style: const TextStyle(
                          color: color2,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _countrySelected = value.toString();
                  _subdivisionSelected = '';
                  _citySelected = '';
                  subdivisionList = [];
                  cityList = [];
                });
                _loadSubdivision().then((value) {
                  setState(() {
                    subdivisionList = value;
                    _subdivisionSelected = '';
                    cityList = [];
                    _subdivisionSelected = '';
                    _citySelected = '';
                  });
                });
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: size.width * 0.9,
            child: DropdownButtonFormField(
              icon: const Icon(Icons.arrow_drop_down, color: color5),
              iconSize: 24,
              dropdownColor: color5,
              elevation: 16,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: color5, width: 1.0),
                    borderRadius: BorderRadius.circular(20)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: color5, width: 1.0),
                    borderRadius: BorderRadius.circular(20)),
                hintText: 'Subdivisión',
                hintStyle: const TextStyle(
                    color: color2,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Urbanist'),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              ),
              items: subdivisionList.map((subdivision) {
                return DropdownMenuItem(
                  value: subdivision['_id'],
                  child: Text(subdivision['name'],
                      style: const TextStyle(
                          color: color2,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _subdivisionSelected = value.toString();
                  _citySelected = '';
                  cityList = [];
                  _loadCities().then((value) {
                    setState(() {
                      cityList = value;
                      print('This is the new elements of cityList$cityList');
                    });
                  });
                });
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: size.width * 0.9,
            child: DropdownButtonFormField(
              icon: const Icon(Icons.arrow_drop_down, color: color5),
              iconSize: 24,
              dropdownColor: color5,
              elevation: 16,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: color5, width: 1.0),
                    borderRadius: BorderRadius.circular(20)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: color5, width: 1.0),
                    borderRadius: BorderRadius.circular(20)),
                hintText: 'Ciudad',
                hintStyle: const TextStyle(
                    color: color2,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Urbanist'),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              ),
              items: cityList.map((city) {
                return DropdownMenuItem(
                  value: city['_id'],
                  child: Text(city['name'],
                      style: const TextStyle(
                          color: color2,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _citySelected = value.toString();
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearMetodoDePago() {
    return Container(
      child: DropdownButtonFormField(
        icon: const Icon(Icons.arrow_drop_down, color: color5),
        iconSize: 24,
        dropdownColor: color5,
        elevation: 16,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: color5, width: 1.0),
              borderRadius: BorderRadius.circular(20)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: color5, width: 1.0),
              borderRadius: BorderRadius.circular(20)),
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: color5, width: 1.0),
              borderRadius: BorderRadius.circular(20)),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        ),
        value: _paymentSelected,
        items: _paymentMethods.map((value) {
          return DropdownMenuItem(
            value: value,
            child: Text(value,
                style: const TextStyle(
                    color: color2,
                    fontSize: 15,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.bold)),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _paymentSelected = value.toString();
          });
        },
      ),
    );
  }

  // Widget _crearTelefono() {
  //   final ordersForm = Provider.of<OrderFormProvider>(context);
  //   return Container(
  //     child: TextFormField(
  //       autocorrect: false,
  //       keyboardType: TextInputType.phone,
  //       onChanged: (value) => ordersForm.telefono = value,
  //       validator: (value) {
  //         if (value == null || value.isEmpty) {
  //           return 'Por favor ingrese su telefono';
  //         }
  //         if (value.length > 8) {
  //           return 'Por favor ingrese un telefono valido';
  //         } else {
  //           return 'se necesita un telefono valido';
  //         }
  //       },
  //       style: const TextStyle(
  //           color: color2,
  //           fontSize: 18,
  //           fontFamily: 'Urbanist',
  //           fontWeight: FontWeight.bold),
  //       controller: telefono,
  //       //cursorColor: firstColor,
  //       decoration: InputDecoration(
  //         enabledBorder: OutlineInputBorder(
  //             borderSide: const BorderSide(color: color5, width: 1.0),
  //             borderRadius: BorderRadius.circular(20)),
  //         focusedBorder: OutlineInputBorder(
  //             borderSide: const BorderSide(color: color5, width: 1.0),
  //             borderRadius: BorderRadius.circular(20)),
  //         prefixIcon: const Padding(
  //           padding: EdgeInsets.all(8.0),
  //           child: Icon(
  //             Icons.phone,
  //             color: color5,
  //             size: 30,
  //           ),
  //         ),
  //         hintText: "Teléfono",
  //         hintStyle: const TextStyle(
  //             color: color2,
  //             fontSize: 15,
  //             fontWeight: FontWeight.bold,
  //             fontFamily: 'Urbanist'),
  //         border: InputBorder.none,
  //       ),
  //     ),
  //   );
  // }

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
          color: Colors.white,
          fontSize: 15,
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
          height: 54,
          width: 200,
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
                createOrder(notaAdicional.text, _citySelected,
                    _subdivisionSelected, _countrySelected, _paymentSelected);
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
                      fontSize: 12,
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
    var total = totalPrice;
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
      text: "\$$totalPrice",
      fontSize: 18,
      fontWeight: FontWeight.w500,
      textAlign: TextAlign.right,
      color: color6,
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
            width: size.width * 0.7,
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

  List<Widget> _buildPayment() {
    return [
      const Text('Agrega un método de pago:',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: color5)),
      const SizedBox(height: 8),
      const Text(
        'selecciona tu forma de pago:',
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

    if (customerName.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const Text('Nombre de Usuario',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: color5)),
          const Text('No hay datos de usuario',
              style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w500, color: color2)),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const Text('Nombre de Usuario',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: color5)),
          Text(customerName,
              style: const TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w500, color: color2)),
        ],
      );
    }
  }

  Widget myProductListCart(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            itemCount: itemsList.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              // ignore: unnecessary_null_comparison
              if (itemsList == null) {
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
                          data: itemsList[index],
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
