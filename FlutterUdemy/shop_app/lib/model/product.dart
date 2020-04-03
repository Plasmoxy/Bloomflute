import 'package:flutter/foundation.dart';

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

  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
