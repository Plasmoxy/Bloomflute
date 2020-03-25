import 'package:flutter/foundation.dart';
import 'package:shop_app/model/mock.dart';
import 'package:shop_app/model/product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [...MOCK_PRODUCTS];
  List<Product> get items => [..._items];

  void addProduct(Product p) {
    // _items.add(p);
    notifyListeners();
  }
}
