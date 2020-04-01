import 'package:flutter/foundation.dart';
import 'package:shop_app/model/mock.dart';
import 'package:shop_app/model/product.dart';

class Products with ChangeNotifier {
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
    notifyListeners();
  }

  Product findById(String id) => _items.firstWhere((p) => p.id == id);
}
