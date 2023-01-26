import 'package:freshbuyer/cart/cart_screen.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield_new.dart';
import 'package:flutter/material.dart';
import 'package:freshbuyer/constants.dart';
import 'package:lottie/lottie.dart';

import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../providers/orders_provider.dart';
import '../tabbar/tabbar.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  dynamic userID;
  void getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      final int? user = prefs.getInt('userID');
      userID = user;
    });
  }

  TextEditingController dni = TextEditingController();
  TextEditingController nombreCompleto = TextEditingController();
  TextEditingController telefono = TextEditingController();
  TextEditingController fecha = TextEditingController();
  TextEditingController hora = TextEditingController();
  //final format = DateFormat('HH:mm');
  final format2 = DateFormat('yyyy-MM-dd');

  void orders(
    String dni,
    String visitante,
    String telefono,
    String hora,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    Map data = {
      "dni": dni,
      "fullName": visitante,
      "phone": telefono,
      "userID": userID,
    };
    // var data2 = jsonEncode(data);
    // print('******************this is data appointment');
    // print(data2);
    // var response = await BaseClient().post(RestApis.visitor, data,
    //     {"Content-Type": "application/json", "accessToken": token});
    // print(response);
    // var rsp = jsonDecode(response);
    // if (rsp['status'] == 'ok') {
    //   // ignore: use_build_context_synchronously
    //   // ignore: use_build_context_synchronously
    //   Navigator.of(context).pushAndRemoveUntil(
    //       MaterialPageRoute(
    //           builder: (BuildContext context) =>
    //               const SafeArea(child: FRTabbarScreen())),
    //       (Route<dynamic> route) => false);
    //   QuickAlert.show(
    //     context: context,
    //     type: QuickAlertType.success,
    //     title: 'Exito',
    //     text: '${rsp['msg']}',
    //     confirmBtnColor: greenDark,
    //     confirmBtnText: 'Aceptar',
    //   );
    //   _showQR(context, rsp['securityCode']);
    // } else {
    //   QuickAlert.show(
    //     context: context,
    //     type: QuickAlertType.error,
    //     title: 'Oops...',
    //     text: '${rsp['msg']}',
    //     confirmBtnColor: redDark,
    //     confirmBtnText: 'Aceptar',
    //   );
    // }
  }

  @override
  void initState() {
    super.initState();
    getUser();
    dni = TextEditingController();
    nombreCompleto = TextEditingController();
    telefono = TextEditingController();
    fecha = TextEditingController();
    hora = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: color5,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (BuildContext context) => const FRTabbarScreen()),
                (Route<dynamic> route) => false);
          },
        ),
        elevation: 10,
        backgroundColor: color5,
        title: const Text('Datos de Orden',
            style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
            width: size.width * 0.9,
            height: size.height * 0.8,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Lottie.asset(
                      'assets/images/prepareOrder.json',
                      width: size.width * 0.8,
                      height: size.height * 0.3,
                    ),
                  ),
                  _appointmentForm(),
                ],
              ),
            )),
      ),
    );
  }

  Widget _appointmentForm() {
    var size = MediaQuery.of(context).size;
    return Form(
        child: Column(
      children: [
        _crearDNI(),
        SizedBox(height: size.height * 0.01),
        _crearVisitante(),
        SizedBox(height: size.height * 0.01),
        //_crearHoraVisita(),
        _crearTelefono(),
        SizedBox(height: size.height * 0.01),
        _crearFechaVisita(),
        SizedBox(height: size.height * 0.01),
        SizedBox(height: size.height * 0.02),
        Container(
          width: size.width * 0.8,
          child: ElevatedButton(
              onPressed: () async {
                orders(
                  dni.text,
                  nombreCompleto.text,
                  telefono.text,
                  hora.text,
                );
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  backgroundColor: color6,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  textStyle: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold)),
              child: const Text("Generar  Orden",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Urbanist'))),
        ),
        SizedBox(height: size.height * 0.03),
      ],
    ));
  }

  Widget _crearDNI() {
    final ordersForm = Provider.of<OrderFormProvider>(context);
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 15),
      child: TextFormField(
        autocorrect: false,
        keyboardType: TextInputType.number,
        onChanged: (value) => ordersForm.dni = value,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor ingrese su DNI';
          }
          if (value.length > 13) {
            return 'Por favor ingrese un DNI valido';
          } else {
            return 'se necesita un DNI valido';
          }
        },
        style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Urbanist'),
        controller: dni,
        //cursorColor: firstColor,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: color6, width: 3.0),
              borderRadius: BorderRadius.circular(20)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: color2, width: 3.0),
              borderRadius: BorderRadius.circular(20)),
          prefixIcon: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.lock_person_outlined,
              color: color6,
              size: 35,
            ),
          ),
          hintText: "DNI",
          hintStyle: const TextStyle(
              color: color2,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Urbanist'),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _crearVisitante() {
    final ordersForm = Provider.of<OrderFormProvider>(context);
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 15),
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
        controller: nombreCompleto,
        //cursorColor: firstColor,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: color6, width: 3.0),
              borderRadius: BorderRadius.circular(20)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: color2, width: 3.0),
              borderRadius: BorderRadius.circular(20)),
          prefixIcon: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.person_pin,
              color: color6,
              size: 35,
            ),
          ),
          hintText: "Nombre ",
          hintStyle: const TextStyle(
              color: color2,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Urbanist'),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _crearTelefono() {
    final ordersForm = Provider.of<OrderFormProvider>(context);
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 15),
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
            color: Colors.black,
            fontSize: 18,
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.bold),
        controller: telefono,
        //cursorColor: firstColor,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: color6, width: 3.0),
              borderRadius: BorderRadius.circular(20)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: color2, width: 3.0),
              borderRadius: BorderRadius.circular(20)),
          prefixIcon: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.contact_phone,
              color: color6,
              size: 35,
            ),
          ),
          hintText: "Teléfono",
          hintStyle: const TextStyle(
              color: color2,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Urbanist'),
          border: InputBorder.none,
        ),
      ),
    );
  }

  // /////WIDGETS DE FECHA Y HORA DE VISITA
  // Widget _crearHoraVisita() {
  //   final ordersForm = Provider.of<OrderFormProvider>(context);
  //   return Container(
  //     margin: const EdgeInsets.only(left: 10, right: 15),
  //     child: DateTimeField(
  //       style: const TextStyle(
  //           color: Colors.black,
  //           fontSize: 18,
  //           fontWeight: FontWeight.bold,
  //           fontFamily: 'Urbanist'),
  //       validator: (value) => value == null ? 'Ingrese una hora' : null,
  //       controller: hora,
  //       format: format,
  //       keyboardType: TextInputType.datetime,
  //       decoration: InputDecoration(
  //         enabledBorder: OutlineInputBorder(
  //             borderSide: const BorderSide(color: redLight, width: 3.0),
  //             borderRadius: BorderRadius.circular(20)),
  //         focusedBorder: OutlineInputBorder(
  //             borderSide: const BorderSide(color: blueDark, width: 3.0),
  //             borderRadius: BorderRadius.circular(20)),
  //         prefixIcon: const Padding(
  //           padding: EdgeInsets.all(8.0),
  //           child: Icon(
  //             Icons.access_time,
  //             color: redLight,
  //             size: 35,
  //           ),
  //         ),
  //         hintText: "Hora de visita",
  //         hintStyle: const TextStyle(
  //             color: blueDark,
  //             fontSize: 18,
  //             fontWeight: FontWeight.bold,
  //             fontFamily: 'Urbanist'),
  //         border: InputBorder.none,
  //       ),
  //       onShowPicker: (context, currentValue) async {
  //         appointmentForm.horaVisita = currentValue.toString();
  //         final time = await showTimePicker(
  //           context: context,
  //           initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
  //         );
  //         return DateTimeField.convert(time);
  //       },
  //     ),
  //   );
  // }

  Widget _crearFechaVisita() {
    final ordersForms = Provider.of<OrderFormProvider>(context);
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 15),
      child: DateTimeField(
        controller: fecha,
        validator: (value) => value == null ? 'Campo requerido' : null,
        style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.bold),
        format: format2,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: color6, width: 3.0),
              borderRadius: BorderRadius.circular(20)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: color2, width: 3.0),
              borderRadius: BorderRadius.circular(20)),
          prefixIcon: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.date_range,
              color: color6,
              size: 35,
            ),
          ),
          hintText: "Fecha de entrega",
          hintStyle: const TextStyle(
              color: color2,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Urbanist'),
          border: InputBorder.none,
        ),
        onShowPicker: (context, currentValue) async {
          ordersForms.fechaEntrega = currentValue.toString();
          final date = await showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
          return date;
        },
      ),
    );
  }

  // // ignore: non_constant_identifier_names
  // _showQR(BuildContext context, data) async {
  //   final _screenshotController = ScreenshotController();
  //   showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //             actions: [
  //               TextButton(
  //                   onPressed: () async {
  //                     await _screenshotController.capture().then((bytes) async {
  //                       final Directory output = await getTemporaryDirectory();
  //                       final String screenshotFilePath =
  //                           '${output.path}/image.png';
  //                       final File screenshortFile = File(screenshotFilePath);
  //                       await screenshortFile.writeAsBytes(bytes!);
  //                       Share.shareFiles([
  //                         screenshotFilePath
  //                       ], text: "He agendado una visita para usted 😃 Solo tiene que mostrar este código al guardia 👮🏻‍♂️",
  //                               sharePositionOrigin: () {
  //                         RenderBox? box =
  //                             context.findRenderObject() as RenderBox?;
  //                         return box!.localToGlobal(Offset.zero) & box.size;
  //                       }())
  //                           .catchError((onError) {
  //                         print(onError);
  //                       });
  //                     });
  //                   },
  //                   child: const Text("Compartir",
  //                       style: TextStyle(
  //                           color: blueDark,
  //                           fontSize: 18,
  //                           fontWeight: FontWeight.bold,
  //                           fontFamily: 'Urbanist'))),
  //               TextButton(
  //                   onPressed: () {
  //                     Navigator.of(context).pop();
  //                     // note.text = "";
  //                     // id.text = "";
  //                     // name.text = "";
  //                     // _sliderEnable = false;
  //                   },
  //                   child: const Text("Cerrar",
  //                       style: TextStyle(
  //                           color: redDark,
  //                           fontSize: 18,
  //                           fontWeight: FontWeight.bold,
  //                           fontFamily: 'Urbanist'))
  //                   // ignore: prefer_const_constructors
  //                   )
  //             ],
  //             title: const Text(
  //                 "Comparta este código QR unicamente con su visita para autorizar acceso a la residencia.",
  //                 textAlign: TextAlign.center,
  //                 style: TextStyle(
  //                     color: Colors.black,
  //                     fontSize: 18,
  //                     fontWeight: FontWeight.normal,
  //                     fontFamily: 'Urbanist')),
  //             contentPadding: const EdgeInsets.all(20),
  //             content: Screenshot(
  //               controller: _screenshotController,
  //               child: Container(
  //                 height: 300,
  //                 width: 300,
  //                 color: Colors.white,
  //                 child:
  //                     QrImage(data: data.toString(), version: QrVersions.auto),
  //               ),
  //             ),
  //           ));
  // }
}
