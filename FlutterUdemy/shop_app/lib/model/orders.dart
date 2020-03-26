import 'package:flutter/foundation.dart';
import 'package:shop_app/model/cart.dart';

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

  void addOrder(List<CartItem> items, double total) {
    _orders.insert(
      0,
      ShopOrder(
        id: DateTime.now().toString(),
        total: total,
        dateTime: DateTime.now(),
        items: items,
      ),
    );
    notifyListeners();
  }
}
