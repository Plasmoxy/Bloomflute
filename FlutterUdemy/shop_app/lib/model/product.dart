import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/util.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  Product.fromJson(String id, Map<String, dynamic> j)
      : id = id,
        title = j['title'],
        description = j['description'],
        price = j['price'],
        imageUrl = j['imageUrl'],
        isFavorite = j['isFavorite'];

  Map<String, dynamic> get json => {
        'title': title,
        'description': description,
        'price': price,
        'imageUrl': imageUrl,
        'isFavorite': isFavorite,
      };

  Future<void> toggleFavorite() async {
    final snapshot = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();

    try {
      // optimistic ui
      final resp = await http.patch(
        '$FHOST/products/$id.json',
        body: jsonEncode({'isFavorite': isFavorite}),
      );
      if (resp.statusCode >= 400) throw ApiError("Error inside toggleFavorite(): status=${resp.statusCode}");
    } catch (err) {
      isFavorite = snapshot;
      notifyListeners();
      print(err);
    }
  }
}
