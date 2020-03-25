import 'package:flutter/material.dart';
import 'package:shop_app/model/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  ProductItem(this.product);

  @override
  Widget build(BuildContext context) {
    return GridTile(child: Image.network(product.imageUrl));
  }
}
