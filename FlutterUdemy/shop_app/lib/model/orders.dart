import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shop_app/model/cart.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/util.dart';

class ShopOrder {
  final String id;
  final double total;
  final List<CartItem> items;
  final DateTime dateTime;

  ShopOrder({
    @required this.id,
    @required this.total,
    @required this.items,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<ShopOrder> _orders = [];

  List<ShopOrder> get orders => [..._orders];

  Future<void> addOrder(List<CartItem> items, double total) async {
    final timestamp = DateTime.now();

    final resp = await http.post(
      '$FHOST/orders.json',
      body: jsonEncode({
        'amount': total,
        'dateTime': timestamp.toIso8601String(),
        'products': items
            .map((x) => {
                  'id': x.id,
                  'title': x.title,
                  'price': x.price,
                  'quantity': x.quantity,
                })
            .toList(),
      }),
    );

    _orders.insert(
      0,
      ShopOrder(
        id: jsonDecode(resp.body)['name'],
        total: total,
        dateTime: timestamp,
        items: items,
      ),
    );
    notifyListeners();
  }
}
