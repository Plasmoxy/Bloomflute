import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/util.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

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

    // errors
    if (data['error'] != null) {
      throw ApiError(data['error']['message']);
    }
  }

  Future<void> signup(String mail, String password) {
    return _authenticate(mail, password, 'signUp');
  }

  Future<void> login(String mail, String password) {
    return _authenticate(mail, password, 'signInWithPassword');
  }
}
