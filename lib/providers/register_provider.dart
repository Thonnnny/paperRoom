import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String reconfirmPassword = '';
  String fullName = '';
  String phone = '';

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    print(formKey.currentState?.validate());

    print('$email - $password - $reconfirmPassword - $fullName - $phone');

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
