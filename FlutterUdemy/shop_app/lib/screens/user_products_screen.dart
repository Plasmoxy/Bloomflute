import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/app_drawer.dart';
import 'package:shop_app/components/user_product_item.dart';
import 'package:shop_app/model/products.dart';

class UserProductsScreen extends StatelessWidget {
  static const route = '/user-products';

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your products'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: products.items.length,
        itemBuilder: (bctx, i) => Column(children: <Widget>[
          UserProductItem(
            products.items[i].title,
            products.items[i].imageUrl,
          ),
          Divider(),
        ]),
      ),
      drawer: AppDrawer(),
    );
  }
}
