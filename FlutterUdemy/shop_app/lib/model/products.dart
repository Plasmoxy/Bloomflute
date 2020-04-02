import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shop_app/model/mock.dart';
import 'package:shop_app/model/product.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/util.dart';

class Products with ChangeNotifier {
  final dbUrl = '$FHOST/products.json';

  List<Product> _items = [...MOCK_PRODUCTS];

  List<Product> get items => [..._items]; // copy
  List<Product> get favoriteItems => _items.where((x) => x.isFavorite).toList();

  void addProduct(Product p) {
    final newProduct = Product(
      title: p.title,
      description: p.description,
      imageUrl: p.imageUrl,
      price: p.price,
      id: DateTime.now().toString(),
    );
    _items.add(newProduct);

    print("POSTING");
    http.post('https://pmxyshopapp.firebaseio.com/products.json', body: newProduct.json);
    notifyListeners();
  }

  void updateProduct(String id, Product p) {
    final i = _items.indexWhere((x) => x.id == id);
    _items[i] = p;
    notifyListeners();
  }

  void deleteProduct(String id) {
    _items.removeWhere((x) => x.id == id);
    notifyListeners();
  }

  Product findById(String id) => _items.firstWhere((p) => p.id == id);
}
