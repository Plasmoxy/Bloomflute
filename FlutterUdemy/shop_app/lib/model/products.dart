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

  Future<void> addProduct(Product p) async {
    // post to server
    print('Posting new product to server');
    final resp = await http.post(
      dbUrl,
      // note: id: null gets auto ignored
      body: jsonEncode(p.json),
    );
    final body = jsonDecode(resp.body);

    // add to memory by using retrieved db id
    _items.add(Product(
      title: p.title,
      description: p.description,
      imageUrl: p.imageUrl,
      price: p.price,
      id: body['name'],
    ));
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
