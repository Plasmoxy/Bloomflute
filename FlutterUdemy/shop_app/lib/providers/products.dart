import 'package:flutter/foundation.dart';
import 'package:shop_app/model/mock.dart';
import 'package:shop_app/model/product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [...MOCK_PRODUCTS];
  List<Product> get items => [..._items]; // copy

  void addProduct(Product p) {
    // _items.add(p);
    notifyListeners();
  }

  Product findById(String id) => _items.firstWhere((p) => p.id == id);
}
