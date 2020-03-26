import 'package:flutter/foundation.dart';
import 'package:shop_app/model/mock.dart';
import 'package:shop_app/model/product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [...MOCK_PRODUCTS];
  var _showFavoritesOnly = false;

  List<Product> get items {
    if (_showFavoritesOnly) {
      return _items.where((x) => x.isFavorite).toList();
    }
    return [..._items]; // copy
  }

  get showFavoritesOnly => _showFavoritesOnly;
  set showFavoritesOnly(bool x) {
    _showFavoritesOnly = x;
    notifyListeners();
  }

  void addProduct(Product p) {
    // _items.add(p);
    notifyListeners();
  }

  Product findById(String id) => _items.firstWhere((p) => p.id == id);
}
