import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/products_grid.dart';
import 'package:shop_app/model/products.dart';

enum FilterOptions { Favorites, All }

class ProductsOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // no listen, i just want to modify state
    final products = Provider.of<Products>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Shop XD'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions val) {
              if (val == FilterOptions.All) {
                products.showFavoritesOnly = false;
              } else {
                products.showFavoritesOnly = true;
              }
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (ctx) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              )
            ],
          )
        ],
      ),
      body: ProductsGrid(),
    );
  }
}
