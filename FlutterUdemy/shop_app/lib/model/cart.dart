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

  // pozn: prerobil som to na mutable modifikacie
  // lebo ako je to imo dost retardovane pouzivat tie immutable
  // metody teraz, ale moze zrobit bugs! so achtung.
  void addItem(Product p) {
    if (_items.containsKey(p.id)) {
      _items[p.id].quantity++;
      // _items.update(
      //   p.id,
      //   (ex) => CartItem(
      //     id: ex.id,
      //     title: ex.title,
      //     price: ex.price,
      //     quantity: ex.quantity + 1,
      //   ),
      // );
    } else {
      _items[p.id] = CartItem(
        id: DateTime.now().toString(),
        title: p.title,
        price: p.price,
        quantity: 1,
      );
      // _items.putIfAbsent(
      //   p.id,
      //   () => CartItem(
      //     id: DateTime.now().toString(),
      //     title: p.title,
      //     price: p.price,
      //     quantity: 1,
      //   ),
      // );
    }
    notifyListeners();
  }
}
