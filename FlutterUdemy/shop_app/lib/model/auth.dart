import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/util.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  Future<void> signup(String mail, String password) async {
    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$FAPIKEY',
      body: jsonEncode({
        'email': mail,
        'password': password,
        'returnSecureToken': true,
      }),
    );
    print(jsonDecode(resp.body));
  }
}
