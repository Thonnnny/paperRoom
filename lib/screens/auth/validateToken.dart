import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ValidateToken {
  dynamic handleSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String yourToken = prefs.getString('sessiontoken') ?? '';
    print('*************************this is the token*********************');
    if (yourToken.isNotEmpty) {
      print(yourToken);
      bool hasExpired = JwtDecoder.isExpired(yourToken);
      if (hasExpired) {
        // handle expired token
        prefs.setBool('savetoken', false);
        print('expired token');
      } else {
        // handle valid token
        prefs.setBool('savetoken', true);
        print('valid token');
      }
    }
  }
}
