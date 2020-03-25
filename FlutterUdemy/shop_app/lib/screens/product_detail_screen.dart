import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/model/products.dart';

class ProductDetailScreen extends StatelessWidget {
  static const route = '/product-detail';
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as String;
    final product = Provider.of<Products>(context, listen: false).findById(id);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
    );
  }
}
