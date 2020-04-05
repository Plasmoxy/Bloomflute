import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shop_app/model/auth.dart';
import 'package:shop_app/model/product.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/util.dart';

class Products with ChangeNotifier {
  List<Product> _items;
  String authToken;
  String userId;

  List<Product> get items => [..._items]; // copy
  List<Product> get favoriteItems => _items.where((x) => x.isFavorite).toList();

  Products();

  factory Products.update(Products p, Auth auth) {
    p.authToken = auth.token;
    p.userId = auth.userId;
    return p;
  }

  Future<void> fetchAndSetProducts() async {
    final resp = await http.get('$FHOST/products.json?auth=$authToken');
    final data = jsonDecode(resp.body) as Map<String, dynamic>;

    final respFav = await http.get('$FHOST/userFavorites/$userId.json?auth=$authToken');
    final favorites = jsonDecode(respFav.body);

    // map every entry to a product
    _items = (data == null)
        ? []
        : data.entries
            .map((x) => Product.fromJson(
                  x.key,
                  favorites == null ? false : favorites[x.key] ?? false,
                  x.value,
                ))
            .toList();
    // notiff
    notifyListeners();
  }

  Future<void> addProduct(Product p) async {
    // post to server
    print('Posting new product to server');
    final resp = await http.post(
      '$FHOST/products.json?auth=$authToken',
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

  Future<void> updateProduct(String id, Product p) async {
    final i = _items.indexWhere((x) => x.id == id);
    if (i >= 0) {
      // server
      await http.patch(
        '$FHOST/products/$id.json?auth=$authToken',
        body: jsonEncode(p.json..remove('isFavorite')), // ignore isFavorite, but doesnt work anyway meh
      );
      // arr
      _items[i] = p;
      notifyListeners();
    } else {
      throw 'Item doesnt exist.';
    }
  }

  Future<void> deleteProduct(String id) async {
    final resp = await http.delete('$FHOST/products/$id.json?auth=$authToken');
    if (resp.statusCode >= 400) {
      throw ApiError("Couldn't delete product, status: ${resp.statusCode}");
    }
    _items.removeWhere((x) => x.id == id);
    notifyListeners();
  }

  Product findById(String id) => _items.firstWhere((p) => p.id == id);
}
