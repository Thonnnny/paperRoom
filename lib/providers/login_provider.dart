import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  bool remember = false;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    print(formKey.currentState?.validate());

    print('$email - $password');

    return formKey.currentState?.validate() ?? false;
  }

  void logOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('sessiontoken');
    prefs.remove('userId');
    prefs.remove('fullname');
    prefs.remove('accesstoken');
  }
}
