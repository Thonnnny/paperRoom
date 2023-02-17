import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freshbuyer/class/classActiveOrders.dart';
import 'package:freshbuyer/components/app_bar.dart';
import 'package:freshbuyer/constants.dart';
import 'package:freshbuyer/model/activeResponses.dart';
import 'package:lottie/lottie.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/base_client.dart';
import '../../helpers/res_apis.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  static String route() => '/history';

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  dynamic userID;
  List<dynamic> arrayhistory = [];
  List<dynamic> arrayDeactiveHistory = [];
  List<dynamic> detailsOrder = [];
  bool showActiveOrders = false;
  bool showHistory = false;
  int? option;

  void getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      final int? user = prefs.getInt('userID');
      userID = user;
      //historyState(0, context);
    });
  }

  @override
  void initState() {
    super.initState();
    getUser();
    getActiveOrders();
    getHistoryOrders();
    // getDetailsOrder(arrayhistory);
    showActiveOrders = true;
    showHistory = false;
  }

  Future<void> getActiveOrders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('accesstoken');
    var response = await BaseClient().get(RestApis.getActiveOrders,
        {"Content-Type": "application/json", "accesstoken": token});
    var rsp = jsonDecode(response);
    if (rsp['type'] == 'success') {
      List<dynamic> activeOrders = rsp['activeOrders'];
      print('This is the response from the active orders screen');
      print(activeOrders);
      setState(() {
        arrayhistory = activeOrders;
      });
      if (arrayhistory.isEmpty) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Oops...',
          text: '${rsp['message']}',
          confirmBtnColor: Colors.red,
          confirmBtnText: 'Reintentar',
        );
      } else {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          title: '${rsp['title']}',
          text: '${rsp['message']}',
          confirmBtnColor: Colors.green,
          confirmBtnText: 'Continuar',
        );
      }
    } else {
      print('No hay ordenes activas');
      setState(() {
        arrayhistory = [];
      });
    }
  }

  Future<void> getHistoryOrders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('accesstoken');
    var response = await BaseClient().get(RestApis.getHistoryOrders,
        {"Content-Type": "application/json", "accesstoken": token});
    var rsp = jsonDecode(response);
    print(response);
    if (rsp['type'] == 'success') {
      List<dynamic> historyOrders = rsp['historyOrders'];
      print('This is the response from the history orders screen');
      print(historyOrders);
      setState(() {
        arrayDeactiveHistory = historyOrders;
      });
      if (arrayDeactiveHistory.isEmpty) {}
    } else {
      print('No hay ordenes en el Historial');
      setState(() {
        arrayDeactiveHistory = [];
      });
    }
  }

  // Future<void> getDetailsOrder(arrayhistory) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? token = prefs.getString('accesstoken');
  //   var response = await BaseClient().get(
  //       RestApis.getOrderDetails + arrayhistory,
  //       {"Content-Type": "application/json", "accesstoken": token});
  //   var rsp = jsonDecode(response);
  //   if (rsp['type'] == 'success') {
  //     List<dynamic> orderDetails = rsp['orderDetails'];
  //     print('This is the response from the active orders Details screen');
  //     print(orderDetails);
  //     setState(() {
  //       detailsOrder = orderDetails;
  //     });
  //   } else {
  //     print('No hay ordenes activas');
  //     setState(() {
  //       detailsOrder = [];
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: color5,
      appBar: FRAppBar.defaultAppBar(
        context,
        title: 'Detalles de ordenes',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 130,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 15,
                        backgroundColor:
                            showActiveOrders == true ? color6 : color1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        print('this is active button Activo');
                        setState(() {
                          showActiveOrders = true;
                          showHistory = false;
                        });
                        //historyState(0, context);
                      },
                      child: Text('Activo',
                          style: TextStyle(
                            color: showActiveOrders == true
                                ? Colors.white
                                : Colors.black,
                          )),
                    ),
                  ),
                  const SizedBox(width: 24),
                  SizedBox(
                    width: 130,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 15,
                        backgroundColor: showHistory == true ? color6 : color1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        print('this is history button Historial');
                        //historyState(1, context);
                        setState(() {
                          showHistory = true;
                          showActiveOrders = false;
                        });
                      },
                      child: Text('Historial',
                          style: TextStyle(
                              color: showHistory == true
                                  ? Colors.white
                                  : Colors.black)),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: color4,
              thickness: 3,
            ),
            if (showActiveOrders && arrayhistory.isNotEmpty) ...[
              _builListActiveOrder(),
            ],
            if (showActiveOrders && arrayhistory.isEmpty) ...[
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 50),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Text(
                        'Aun no tienes ordenes activas 😊\nHaz una orden!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                      Lottie.asset('assets/images/OrderNow.json'),
                      Container(
                        height: 50,
                        width: 200,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: color6,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/home');
                          },
                          child: const Text('Ordenar ahora',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Urbanist')),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            if (showActiveOrders == false &&
                arrayDeactiveHistory.isNotEmpty) ...[
              _builListHistoryOrder(),
            ],
            if (showActiveOrders == false && arrayDeactiveHistory.isEmpty) ...[
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 50),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Text(
                        'Aun no tienes historial de ordenes😊\nHaz una orden!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                      Lottie.asset('assets/images/OrderNow.json'),
                      Container(
                        height: 50,
                        width: 200,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: color6,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/home');
                          },
                          child: const Text('Ordenar ahora',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Urbanist')),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _builListActiveOrder() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: arrayhistory.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  color: Colors.grey[100],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.all(5.0),
                  elevation: 10,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: ExpansionTile(
                          collapsedIconColor: color6,
                          collapsedTextColor: Colors.black,
                          textColor: color3,
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.person,
                                    color: color5,
                                    size: 35,
                                  ),
                                  const SizedBox(width: 15),
                                  Text(
                                    arrayhistory[index]['client']['fullname'] ==
                                            ''
                                        ? 'Cliente'
                                        : arrayhistory[index]['client']
                                            ['fullname'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text('Informacion del usuario: ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0)),
                                ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 20),
                                  title: const Text('Email: ',
                                      style: TextStyle(
                                          color: color6,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0)),
                                  subtitle: Text(
                                      arrayhistory[index]['client']['email'] ==
                                              ''
                                          ? 'sin email'
                                          : arrayhistory[index]['client']
                                              ['email'],
                                      style: const TextStyle(
                                          color: color3,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15.0)),
                                  leading: const Icon(Icons.email,
                                      color: color5, size: 35.0),
                                ),
                                ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 20),
                                  title: const Text('Telefono: ',
                                      style: TextStyle(
                                          color: color6,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0)),
                                  subtitle: Text(
                                      arrayhistory[index]['client']['phone'] ==
                                              ''
                                          ? 'Sin telefono Registrado'
                                          : arrayhistory[index]['client']
                                              ['phone'],
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15.0)),
                                  leading: const Icon(Icons.phone,
                                      color: color5, size: 35.0),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const Text('Informacion del pedido: ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0)),
                                ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 14),
                                  title: const Text('Estado  Actual: ',
                                      style: TextStyle(
                                          color: color6,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0)),
                                  subtitle: Text(
                                      '${arrayhistory[index]['actualStatus']}',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15.0)),
                                  leading: const Icon(
                                      Icons.pending_actions_sharp,
                                      color: color5,
                                      size: 35.0),
                                ),
                                ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 14),
                                  title: const Text('Estado de pago: ',
                                      style: TextStyle(
                                          color: color6,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0)),
                                  subtitle: Text(
                                      '${arrayhistory[index]['paymentStatus']}',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15.0)),
                                  leading: const Icon(Icons.payment_rounded,
                                      color: color5, size: 35.0),
                                ),
                                ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 14),
                                  title: const Text('Metodo de pago: ',
                                      style: TextStyle(
                                          color: color6,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0)),
                                  subtitle: Text(
                                      '${arrayhistory[index]['paymentMethod']}',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15.0)),
                                  leading: const Icon(Icons.payments,
                                      color: color5, size: 35.0),
                                ),
                                ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 14),
                                  title: const Text('Cantidad de productos: ',
                                      style: TextStyle(
                                          color: color6,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0)),
                                  subtitle: Text(
                                      '${arrayhistory[index]['itemsCount']}',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15.0)),
                                  leading: const Icon(
                                      Icons.shopping_cart_checkout,
                                      color: color5,
                                      size: 35.0),
                                ),
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  width: size.width * 0.6,
                                  height: size.height * 0.05,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: color5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    onPressed: () {
                                      // setState(() {
                                      //   getDetailsOrder(
                                      //       arrayhistory[index]['id']);
                                      //   _showActiveOrders(
                                      //       arrayhistory[index]['id']);
                                      // });
                                      // _showActiveOrders(
                                      //     arrayhistory[index]['id']);
                                    },
                                    child: Row(
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        const Icon(
                                          Icons.remove_red_eye,
                                          color: color2,
                                          size: 25,
                                        ),
                                        SizedBox(width: size.width * 0.02),
                                        const Text(
                                          'Ver detalles del pedido',
                                          style: TextStyle(
                                              color: color3,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Urbanist'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _builListHistoryOrder() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: arrayDeactiveHistory.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  color: Colors.grey[100],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.all(5.0),
                  elevation: 10,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: ExpansionTile(
                          collapsedIconColor: color6,
                          collapsedTextColor: Colors.black,
                          textColor: color3,
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.person,
                                    color: color5,
                                    size: 35,
                                  ),
                                  const SizedBox(width: 15),
                                  Text(
                                    arrayDeactiveHistory[index]['client']
                                                ['fullname'] ==
                                            ''
                                        ? 'Cliente'
                                        : arrayhistory[index]['client']
                                            ['fullname'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text('Informacion del usuario: ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0)),
                                ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 20),
                                  title: const Text('Email: ',
                                      style: TextStyle(
                                          color: color6,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0)),
                                  subtitle: Text(
                                      arrayDeactiveHistory[index]['client']
                                                  ['email'] ==
                                              ''
                                          ? 'sin email'
                                          : arrayDeactiveHistory[index]
                                              ['client']['email'],
                                      style: const TextStyle(
                                          color: color3,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15.0)),
                                  leading: const Icon(Icons.email,
                                      color: color5, size: 35.0),
                                ),
                                ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 20),
                                  title: const Text('Telefono: ',
                                      style: TextStyle(
                                          color: color6,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0)),
                                  subtitle: Text(
                                      arrayDeactiveHistory[index]['client']
                                                  ['phone'] ==
                                              ''
                                          ? 'Sin telefono Registrado'
                                          : arrayhistory[index]['client']
                                              ['phone'],
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15.0)),
                                  leading: const Icon(Icons.phone,
                                      color: color5, size: 35.0),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const Text('Informacion del pedido: ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0)),
                                ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 14),
                                  title: const Text('Estado  Actual: ',
                                      style: TextStyle(
                                          color: color6,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0)),
                                  subtitle: Text(
                                      '${arrayDeactiveHistory[index]['actualStatus']}',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15.0)),
                                  leading: const Icon(
                                      Icons.pending_actions_sharp,
                                      color: color5,
                                      size: 35.0),
                                ),
                                ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 14),
                                  title: const Text('Estado de pago: ',
                                      style: TextStyle(
                                          color: color6,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0)),
                                  subtitle: Text(
                                      '${arrayDeactiveHistory[index]['paymentStatus']}',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15.0)),
                                  leading: const Icon(Icons.payment_rounded,
                                      color: color5, size: 35.0),
                                ),
                                ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 14),
                                  title: const Text('Metodo de pago: ',
                                      style: TextStyle(
                                          color: color6,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0)),
                                  subtitle: Text(
                                      '${arrayDeactiveHistory[index]['paymentMethod']}',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15.0)),
                                  leading: const Icon(Icons.payments,
                                      color: color5, size: 35.0),
                                ),
                                ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 14),
                                  title: const Text('Cantidad de productos: ',
                                      style: TextStyle(
                                          color: color6,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0)),
                                  subtitle: Text(
                                      '${arrayDeactiveHistory[index]['itemsCount']}',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15.0)),
                                  leading: const Icon(
                                      Icons.shopping_cart_checkout,
                                      color: color5,
                                      size: 35.0),
                                ),
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  width: size.width * 0.6,
                                  height: size.height * 0.05,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: color5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    onPressed: () {
                                      // setState(() {
                                      //   getDetailsOrder(
                                      //       arrayhistory[index]['id']);
                                      //   _showActiveOrders(
                                      //       arrayhistory[index]['id']);
                                      // });
                                      // _showActiveOrders(
                                      //     arrayhistory[index]['id']);
                                    },
                                    child: Row(
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        const Icon(
                                          Icons.remove_red_eye,
                                          color: color2,
                                          size: 25,
                                        ),
                                        SizedBox(width: size.width * 0.02),
                                        const Text(
                                          'Ver detalles del pedido',
                                          style: TextStyle(
                                              color: color3,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Urbanist'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
