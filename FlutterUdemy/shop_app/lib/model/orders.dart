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

  Future<void> fetchAndSetOrders() async {
    final resp = await http.get('$FHOST/orders.json');
    final data = jsonDecode(resp.body) as Map<String, dynamic>;

    _orders = data == null
        ? []
        : data.entries
            .map((x) => ShopOrder(
                  id: x.key,
                  total: x.value['total'],
                  dateTime: DateTime.parse(x.value['dateTime']),
                  items: (x.value['products'] as List<dynamic>)
                      .map((item) => CartItem(
                            id: item['id'],
                            price: item['price'],
                            quantity: item['quantity'],
                            title: item['title'],
                          ))
                      .toList(),
                ))
            .toList();

    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> items, double total) async {
    final timestamp = DateTime.now();

    final resp = await http.post(
      '$FHOST/orders.json',
      body: jsonEncode({
        'total': total,
        'dateTime': timestamp.toIso8601String(),
        'items': items
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
