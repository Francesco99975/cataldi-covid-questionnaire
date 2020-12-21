import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonalInfo with ChangeNotifier {
  String _firstName = "";
  String _middleName = "";
  String _lastName = "";

  Future<void> loadInfo() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _firstName = prefs.getString('firstName');
      _middleName = prefs.getString('middleName');
      _lastName = prefs.getString('lastName');
    } catch (e) {
      print("An error occurred while loading info");
      print(e);
    }
  }

  Future<void> setInfo({String fn, String ln, String mn = ""}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('firstName', fn);
      await prefs.setString('middleName', mn);
      await prefs.setString('lastName', ln);
    } catch (e) {
      print("An error occurred while setting info");
      print(e);
    }
  }

  String get firstName => _firstName;
  String get middleName => _middleName;
  String get lastName => _lastName;
}
