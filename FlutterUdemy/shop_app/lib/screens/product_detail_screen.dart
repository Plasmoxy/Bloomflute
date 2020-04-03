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
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Container(
            height: 300,
            width: double.infinity,
            child: product.imageUrl.isEmpty ? null : Image.network(product.imageUrl, fit: BoxFit.cover),
          ),
          SizedBox(height: 10),
          Text(
            '${product.price} €',
            style: TextStyle(color: Colors.teal, fontSize: 20),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              product.description,
              textAlign: TextAlign.center,
              softWrap: true,
            ),
          )
        ]),
      ),
    );
  }
}
