import 'package:flutter/material.dart';

class OrderFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String dni = '';
  String nombreCliente = '';
  String fechaEntrega = '';
  String telefono = '';
  String direccion = '';

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    print(formKey.currentState?.validate());

    print('$dni - $nombreCliente - $fechaEntrega - $telefono - $direccion');

    return formKey.currentState?.validate() ?? false;
  }
}
