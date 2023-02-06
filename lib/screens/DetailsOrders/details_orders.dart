import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freshbuyer/components/app_bar.dart';
import 'package:freshbuyer/constants.dart';
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
  }

  void getCartDetails(int isHistory, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('accesstoken');

    final response = await BaseClient().get(RestApis.getCart,
        {"Content-Type": "application/json", "accesstoken": token});
    final rsp = jsonDecode(response);
    if (rsp['type'] == 'success') {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: '${rsp['msg']}',
        confirmBtnColor: Colors.red,
        confirmBtnText: 'Reintentar',
      );
    } else {
      setState(() {
        arrayhistory = rsp['cart'];
      });
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: 'Exito',
        text: '${rsp['message']}',
        confirmBtnColor: Colors.green,
        confirmBtnText: 'Aceptar',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                child: Row(
                  children: [
                    SizedBox(
                      width: 130,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 15,
                          backgroundColor: option == 0 ? color6 : color1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          print('this is history button Activo');
                          //historyState(0, context);
                        },
                        child: Text('Activo',
                            style: TextStyle(
                              color: option == 0 ? Colors.white : Colors.black,
                            )),
                      ),
                    ),
                    const SizedBox(width: 24),
                    SizedBox(
                      width: 130,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 15,
                          backgroundColor: option == 1 ? color6 : color1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          print('this is history button Historial');
                          //historyState(1, context);
                        },
                        child: Text('Historial',
                            style: TextStyle(
                                color:
                                    option == 1 ? Colors.white : Colors.black)),
                      ),
                    )
                  ],
                ),
              ),
              // Container(
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              //   child: _buildList(context),
              // ),
            ],
          ),
        ));
  }

  // Widget _buildList(BuildContext context) {
  //   return SingleChildScrollView(
  //     child: Column(
  //       children: [
  //         ListView.builder(
  //           itemCount: arrayhistory.length,
  //           scrollDirection: Axis.vertical,
  //           shrinkWrap: true,
  //           physics: const ClampingScrollPhysics(),
  //           itemBuilder: (context, index) {
  //            // print(arrayhistory[index]);
  //             return option == 0
  //                 ? Column(
  //                     children: [
  //                       Card(
  //                         color: Colors.grey[100],
  //                         shape: RoundedRectangleBorder(
  //                             borderRadius: BorderRadius.circular(10)),
  //                         margin: const EdgeInsets.all(5.0),
  //                         elevation: 10,
  //                         child: Column(
  //                           children: [
  //                             Padding(
  //                               padding: EdgeInsets.all(5.0),
  //                               child: ExpansionTile(
  //                                 collapsedIconColor: blueDark,
  //                                 collapsedTextColor: Colors.black,
  //                                 textColor: redLight,
  //                                 title: Column(
  //                                   crossAxisAlignment:
  //                                       CrossAxisAlignment.start,
  //                                   children: [
  //                                     Row(
  //                                       children: [
  //                                         const Icon(
  //                                           Icons.person,
  //                                           color: redLight,
  //                                           size: 35,
  //                                         ),
  //                                         Text(
  //                                           arrayhistory[index]['Visitante'] ==
  //                                                   ''
  //                                               ? 'Visitante'
  //                                               : arrayhistory[index]
  //                                                   ['Visitante'],
  //                                           style: const TextStyle(
  //                                             fontWeight: FontWeight.bold,
  //                                             fontSize: 18,
  //                                           ),
  //                                         ),
  //                                       ],
  //                                     )
  //                                   ],
  //                                 ),
  //                                 children: [
  //                                   ListTile(
  //                                     contentPadding:
  //                                         const EdgeInsets.symmetric(
  //                                             vertical: 0, horizontal: 20),
  //                                     title: const Text('Fecha de Asignada: ',
  //                                         style: TextStyle(
  //                                             color: Colors.black,
  //                                             fontWeight: FontWeight.bold,
  //                                             fontSize: 18.0)),
  //                                     subtitle: Text(
  //                                         '${arrayhistory[index]['FechaAsignada']}',
  //                                         style: const TextStyle(
  //                                             color: Colors.black,
  //                                             fontWeight: FontWeight.normal,
  //                                             fontSize: 15.0)),
  //                                     leading: const Icon(
  //                                         Icons.calendar_month_outlined,
  //                                         color: redLight,
  //                                         size: 35.0),
  //                                   ),
  //                                   ListTile(
  //                                     contentPadding:
  //                                         const EdgeInsets.symmetric(
  //                                             vertical: 0, horizontal: 20),
  //                                     title: const Text('Hora de Asignada: ',
  //                                         style: TextStyle(
  //                                             color: Colors.black,
  //                                             fontWeight: FontWeight.bold,
  //                                             fontSize: 18.0)),
  //                                     subtitle: Text(
  //                                         '${arrayhistory[index]['HoraAsignada']}',
  //                                         style: const TextStyle(
  //                                             color: Colors.black,
  //                                             fontWeight: FontWeight.normal,
  //                                             fontSize: 15.0)),
  //                                     leading: const Icon(
  //                                         Icons.access_time_filled,
  //                                         color: redLight,
  //                                         size: 35.0),
  //                                   ),
  //                                   ListTile(
  //                                     contentPadding:
  //                                         const EdgeInsets.symmetric(
  //                                             vertical: 0, horizontal: 20),
  //                                     title: const Text('Fecha de Entrada: ',
  //                                         style: TextStyle(
  //                                             color: Colors.black,
  //                                             fontWeight: FontWeight.bold,
  //                                             fontSize: 18.0)),
  //                                     subtitle: Text(
  //                                         arrayhistory[index]['FechaEntrada'] ==
  //                                                 null
  //                                             ? 'No ha ingresado'
  //                                             : '${arrayhistory[index]['FechaEntrada']}',
  //                                         style: const TextStyle(
  //                                             color: Colors.black,
  //                                             fontWeight: FontWeight.normal,
  //                                             fontSize: 15.0)),
  //                                     leading: const Icon(
  //                                         Icons.calendar_month_outlined,
  //                                         color: redLight,
  //                                         size: 35.0),
  //                                   ),
  //                                   ListTile(
  //                                     contentPadding:
  //                                         const EdgeInsets.symmetric(
  //                                             vertical: 0, horizontal: 20),
  //                                     title: const Text('Hora de Entrada: ',
  //                                         style: TextStyle(
  //                                             color: Colors.black,
  //                                             fontWeight: FontWeight.bold,
  //                                             fontSize: 18.0)),
  //                                     subtitle: Text(
  //                                         arrayhistory[index]['HoraEntrada'] ==
  //                                                 null
  //                                             ? 'No ha ingresado'
  //                                             : '${arrayhistory[index]['HoraEntrada']}',
  //                                         style: const TextStyle(
  //                                             color: Colors.black,
  //                                             fontWeight: FontWeight.normal,
  //                                             fontSize: 15.0)),
  //                                     leading: const Icon(
  //                                         Icons.access_time_filled,
  //                                         color: redLight,
  //                                         size: 35.0),
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ],
  //                   )
  //                 : Card(
  //                     color: Colors.grey[100],
  //                     shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(10)),
  //                     margin: const EdgeInsets.all(5.0),
  //                     elevation: 10,
  //                     child: Column(
  //                       children: [
  //                         Padding(
  //                           padding: EdgeInsets.all(5.0),
  //                           child: ExpansionTile(
  //                             collapsedIconColor: blueDark,
  //                             collapsedTextColor: Colors.black,
  //                             textColor: redLight,
  //                             title: Column(
  //                               crossAxisAlignment: CrossAxisAlignment.start,
  //                               children: [
  //                                 Row(
  //                                   children: [
  //                                     const Icon(
  //                                       Icons.person,
  //                                       color: redLight,
  //                                       size: 35,
  //                                     ),
  //                                     Text(
  //                                       arrayhistory[index]['Visitante'] == ''
  //                                           ? 'Visitante'
  //                                           : arrayhistory[index]['Visitante'],
  //                                       style: const TextStyle(
  //                                         fontWeight: FontWeight.bold,
  //                                         fontSize: 18,
  //                                       ),
  //                                     ),
  //                                   ],
  //                                 )
  //                               ],
  //                             ),
  //                             children: [
  //                               ListTile(
  //                                 contentPadding: const EdgeInsets.symmetric(
  //                                     vertical: 0, horizontal: 20),
  //                                 title: const Text('Fecha de entrada: ',
  //                                     style: TextStyle(
  //                                         color: Colors.black,
  //                                         fontWeight: FontWeight.bold,
  //                                         fontSize: 18.0)),
  //                                 subtitle: Text(
  //                                     '${arrayhistory[index]['FechaEntrada']}',
  //                                     style: const TextStyle(
  //                                         color: Colors.black,
  //                                         fontWeight: FontWeight.normal,
  //                                         fontSize: 15.0)),
  //                                 leading: const Icon(
  //                                     Icons.calendar_month_outlined,
  //                                     color: redLight,
  //                                     size: 35.0),
  //                               ),
  //                               ListTile(
  //                                 contentPadding: const EdgeInsets.symmetric(
  //                                     vertical: 0, horizontal: 20),
  //                                 title: const Text('Hora de entrada: ',
  //                                     style: TextStyle(
  //                                         color: Colors.black,
  //                                         fontWeight: FontWeight.bold,
  //                                         fontSize: 18.0)),
  //                                 subtitle: Text(
  //                                     '${arrayhistory[index]['HoraEntrada']}',
  //                                     style: const TextStyle(
  //                                         color: Colors.black,
  //                                         fontWeight: FontWeight.normal,
  //                                         fontSize: 15.0)),
  //                                 leading: const Icon(Icons.access_time_filled,
  //                                     color: redLight, size: 35.0),
  //                               ),
  //                               ListTile(
  //                                 contentPadding: const EdgeInsets.symmetric(
  //                                     vertical: 0, horizontal: 20),
  //                                 title: const Text('Fecha de salida: ',
  //                                     style: TextStyle(
  //                                         color: Colors.black,
  //                                         fontWeight: FontWeight.bold,
  //                                         fontSize: 18.0)),
  //                                 subtitle: Text(
  //                                     '${arrayhistory[index]['FechaSalida']}',
  //                                     style: const TextStyle(
  //                                         color: Colors.black,
  //                                         fontWeight: FontWeight.normal,
  //                                         fontSize: 15.0)),
  //                                 leading: const Icon(
  //                                     Icons.calendar_month_outlined,
  //                                     color: redLight,
  //                                     size: 35.0),
  //                               ),
  //                               ListTile(
  //                                 contentPadding: const EdgeInsets.symmetric(
  //                                     vertical: 0, horizontal: 20),
  //                                 title: const Text('Hora de salida: ',
  //                                     style: TextStyle(
  //                                         color: Colors.black,
  //                                         fontWeight: FontWeight.bold,
  //                                         fontSize: 18.0)),
  //                                 subtitle: Text(
  //                                     '${arrayhistory[index]['HoraSalida']}',
  //                                     style: const TextStyle(
  //                                         color: Colors.black,
  //                                         fontWeight: FontWeight.normal,
  //                                         fontSize: 15.0)),
  //                                 leading: const Icon(Icons.access_time_filled,
  //                                     color: redLight, size: 35.0),
  //                               ),
  //                               ListTile(
  //                                 contentPadding: const EdgeInsets.symmetric(
  //                                     vertical: 0, horizontal: 20),
  //                                 title: const Text('Guardia de entrada: ',
  //                                     style: TextStyle(
  //                                         color: Colors.black,
  //                                         fontWeight: FontWeight.bold,
  //                                         fontSize: 18.0)),
  //                                 subtitle: Text(
  //                                     arrayhistory[index]['PrimerG'] ??
  //                                         'Pendiente',
  //                                     style: const TextStyle(
  //                                         color: Colors.black,
  //                                         fontWeight: FontWeight.normal,
  //                                         fontSize: 15.0)),
  //                                 leading: const Icon(Icons.policy_outlined,
  //                                     color: redLight, size: 35.0),
  //                               ),
  //                               ListTile(
  //                                 contentPadding: const EdgeInsets.symmetric(
  //                                     vertical: 0, horizontal: 20),
  //                                 title: const Text('Guardia de Salida: ',
  //                                     style: TextStyle(
  //                                         color: Colors.black,
  //                                         fontWeight: FontWeight.bold,
  //                                         fontSize: 18.0)),
  //                                 subtitle: Text(
  //                                     arrayhistory[index]['SegundoG'] ??
  //                                         'Pendiente',
  //                                     style: const TextStyle(
  //                                         color: Colors.black,
  //                                         fontWeight: FontWeight.normal,
  //                                         fontSize: 15.0)),
  //                                 leading: const Icon(Icons.policy_outlined,
  //                                     color: redLight, size: 35.0),
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   );
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
