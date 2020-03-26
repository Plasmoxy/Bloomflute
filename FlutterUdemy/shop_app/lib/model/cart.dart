import 'package:flutter/foundation.dart';
import 'package:shop_app/model/product.dart';

class CartItem {
  final String id;
  final String title;
  final double price;
  int quantity;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}

class Cart with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};
  int get itemCount => _items.length;
  double get totalSum => _items.entries.fold(
        0,
        (a, x) => a + x.value.price * x.value.quantity,
      );

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  // pozn: prerobil som to na mutable modifikacie
  // lebo ako je to imo dost retardovane pouzivat tie immutable
  // metody teraz, ale moze zrobit bugs! so achtung.
  void addItem(Product p) {
    if (_items.containsKey(p.id)) {
      _items[p.id].quantity++;
    } else {
      _items[p.id] = CartItem(
        id: DateTime.now().toString(),
        title: p.title,
        price: p.price,
        quantity: 1,
      );
    }
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
