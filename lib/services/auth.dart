import 'package:movies_app/constants.dart';
import 'package:movies_app/models/user.dart';
import 'package:movies_app/view_models/errors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static late final AuthService instance;
  static bool _isInitialized = false;
  late final SharedPreferences _sharedPreferences;

  late User _user;

  AuthService._(prefs) {
    _sharedPreferences = prefs;
  }

  static Future<void> initialize() async {
    if (!_isInitialized) {
      SharedPreferences preference = await SharedPreferences.getInstance();
      instance = AuthService._(preference);
      _isInitialized = true;
    } else {
      throw Exception('Shared preference manager is already initialized');
    }
  }

  isLoggedIn() {
    buildUser();
    return instance._sharedPreferences.getBool(loggedInKey) ?? false;
  }

  signUp() {
    //Call the sign up function
  }

  buildUser() {
    _user = User(phone: instance._sharedPreferences.getString(phoneKey) ?? "", name: instance._sharedPreferences.getString(nameKey) ?? "");
  }

 User get user =>_user;

  verifyOTP({required String phone, required String name, required String otp}) {
    if (otp == "123456") {
      instance._sharedPreferences.setString(phoneKey, phone);
      instance._sharedPreferences.setString(nameKey, name);
      instance._sharedPreferences.setBool(loggedInKey, true);
      buildUser();
    } else {
      throw UserFriendlyException(message: "Incorrect OTP entered");
    }
  }

  logout() {
    instance._sharedPreferences.clear();
  }
}
