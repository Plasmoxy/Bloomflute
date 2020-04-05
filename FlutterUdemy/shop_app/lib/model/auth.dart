import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/util.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _logoutTimer;

  bool get isAuthenticated {
    return token != null;
  }

  String get token {
    if (_expiryDate != null && _expiryDate.isAfter(DateTime.now())) {
      return _token;
    }
    return null;
  }

  String get userId => _userId;

  Future<void> _authenticate(String email, String password, String urlSegment) async {
    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=$FAPIKEY',
      body: jsonEncode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );
    final data = jsonDecode(resp.body);

    // error
    if (data['error'] != null) {
      throw ApiError(data['error']['message']);
    }

    // success
    _token = data['idToken'];
    _userId = data['localId'];
    _expiryDate = DateTime.now().add(Duration(
      seconds: int.parse(data['expiresIn']),
    ));
    _startAutoLogoutTimer();
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    final userData = jsonEncode({
      'token': _token,
      'userId': _userId,
      'expiryDate': _expiryDate.toIso8601String(),
    });
    await prefs.setString('userData', userData);
  }

  Future<bool> tryAutoLogin() async {
    print("Trying auto login");
    final prefs = await SharedPreferences.getInstance();
    // if no userData
    if (!prefs.containsKey('userData')) {
      print("Autologin fail: prefs dont contain key userData");
      return false;
    }
    final udata = jsonDecode(prefs.getString('userData'));

    // validate token by expiry date
    final expiry = DateTime.parse(udata['expiryDate']);
    if (expiry.isAfter(DateTime.now())) {
      print("Autologin fail: expiry is after now");
      return false;
    }

    _token = udata['token'];
    _userId = udata['userId'];
    _expiryDate = expiry;
    notifyListeners();

    print("Auto login done with udata: $udata");
    _startAutoLogoutTimer();
    return true;
  }

  Future<void> signup(String mail, String password) {
    return _authenticate(mail, password, 'signUp');
  }

  Future<void> login(String mail, String password) {
    return _authenticate(mail, password, 'signInWithPassword');
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _expiryDate = null;
    if (_logoutTimer != null) {
      _logoutTimer.cancel();
      _logoutTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  void _startAutoLogoutTimer() {
    if (_logoutTimer != null) _logoutTimer.cancel();

    final secondsToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _logoutTimer = Timer(Duration(seconds: secondsToExpiry), logout);
  }
}
