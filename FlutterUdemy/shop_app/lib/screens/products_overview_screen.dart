import 'package:flutter/material.dart';
import 'package:shop_app/components/products_grid.dart';

enum FilterOptions { Favorites, All }

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop XD'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions val) {
              setState(() {
                if (val == FilterOptions.All) {
                  showOnlyFavorites = false;
                } else {
                  showOnlyFavorites = true;
                }
              });
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
      body: ProductsGrid(showOnlyFavorites),
    );
  }
}
