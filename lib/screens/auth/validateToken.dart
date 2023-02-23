import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ValidateToken {
  dynamic handleSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? yourToken = prefs.getString('sessiontoken');
    print('*************************this is the token*********************');
    print(yourToken);
    if (yourToken == null) {
      print('no token, is null');
      prefs.setBool('savetoken', false);
    } else {
      if (yourToken.isNotEmpty) {
        print(yourToken);
        bool hasExpired = JwtDecoder.isExpired(yourToken);
        if (hasExpired == true) {
          // handle expired token
          prefs.setBool('savetoken', false);
          print('expired token');
        } else {
          // handle valid tokren
          prefs.setBool('savetoken', true);
          print('valid token');
        }
      }
    }
  }
}
