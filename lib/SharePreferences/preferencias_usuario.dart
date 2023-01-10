// import 'package:shared_preferences/shared_preferences.dart';

// class PreferenciasUsuario {
//   static final PreferenciasUsuario _instancia = PreferenciasUsuario._internal();

//   factory PreferenciasUsuario() {
//     return _instancia;
//   }

//   PreferenciasUsuario._internal();

//   SharedPreferences? _prefs;

//   initPrefs() async {
//     _prefs = await SharedPreferences.getInstance();
//   }

//   // GET y SET del nombreUsuario
//   get nombreUsuario {
//     return _prefs?.getString('nombreUsuario') ?? '';
//   }

//   set nombreUsuario(String value) {
//     _prefs?.setString('nombreUsuario', value);
//   }

//   // GET y SET del nombreUsuario
//   get nombreUsuarioFull {
//     return _prefs?.getString('nombreUsuarioFull') ?? '';
//   }

//   set nombreUsuarioFull(String value) {
//     _prefs?.setString('nombreUsuarioFull', value);
//   }

//   // GET y SET del nombreUsuario
//   get emailUsuario {
//     return _prefs?.getString('emailUsuario') ?? '';
//   }

//   set emailUsuario(String value) {
//     _prefs?.setString('emailUsuario', value);
//   }

//   get userId {
//     return _prefs?.getString('agentEmployeeId') ?? '';
//   }

//   set userId(String value) {
//     _prefs?.setString('userId', value.toString());
//   }

//   // GET y SET del salida
//   get passwordUser {
//     return _prefs?.getString('passwordUser') ?? '';
//   }

//   set passwordUser(String value) {
//     _prefs?.setString('passwordUser', value.toString());
//   }

//   // GET y SET de tokenIdMobile
//   get tokenIdMobile {
//     return _prefs?.getString('tokenIdMobile') ?? '';
//   }

//   set tokenIdMobile(String value) {
//     _prefs?.setString('tokenIdMobile', value);
//   }

//   // GET y SET de tokenIdMobile
//   get phone {
//     return _prefs?.getString('phone') ?? '';
//   }

//   set phone(String value) {
//     _prefs?.setString('phone', value);
//   }

//   // GET y SET version
//   get versionNew {
//     return _prefs?.getString('versionNew') ?? '';
//   }

//   set versionNew(String value) {
//     _prefs?.setString('versionNew', value);
//   }

//   // GET y SET version
//   get versionOld {
//     return _prefs?.getString('versionOld') ?? '';
//   }

//   set versionOld(String value) {
//     _prefs?.setString('versionOld', value);
//   }
// }
