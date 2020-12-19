import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Status with ChangeNotifier {
  static const _STATUS_KEY = 'completed';
  static const _EXPIRY_KEY = 'expiryDate';
  bool _submissionCompleted = false;
  DateTime _expiryDate;

  Future<void> loadStatus() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.containsKey(_STATUS_KEY)
          ? _submissionCompleted = prefs.getBool(_STATUS_KEY)
          : await prefs.setBool(_STATUS_KEY, false);

      _expiryDate = prefs.getString(_EXPIRY_KEY) != ''
          ? DateTime.parse(prefs.getString(_EXPIRY_KEY))
          : null;
      if (_expiryDate != null) _autoWatcher();
    } catch (e) {
      print("An Error Occurred while retriving vars: completed");
      print(e);
    }
  }

  Future<void> setStatus(bool cmp) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_STATUS_KEY, cmp);
      _submissionCompleted = cmp;
      notifyListeners();
    } catch (e) {
      print("An Error Occurred while setting status: completed");
      print(e);
    }
  }

  Future<void> setExpiryDate(DateTime date) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(_EXPIRY_KEY, date.toIso8601String());
      _expiryDate = date;
      _autoWatcher();
    } catch (e) {
      print("An Error Occurred while setting key: expiry date");
      print(e);
    }
  }

  void _autoWatcher() {
    Timer(Duration(seconds: _expiryDate.difference(DateTime.now()).inSeconds),
        () async => await setStatus(false));
  }

  bool get completed => _submissionCompleted;
}
