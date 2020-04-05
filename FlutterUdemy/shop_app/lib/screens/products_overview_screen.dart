import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/app_drawer.dart';
import 'package:shop_app/components/badge.dart';
import 'package:shop_app/components/products_grid.dart';
import 'package:shop_app/model/cart.dart';
import 'package:shop_app/model/products.dart';
import 'package:shop_app/model/theme_preference.dart';
import 'package:shop_app/screens/cart_screen.dart';

class ProductsOverviewScreen extends StatefulWidget {
  static const route = '/overview';

  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _loading = false;
  var showOnlyFavorites = false;

  @override
  void initState() {
    final products = Provider.of<Products>(context, listen: false);
    _loading = true;

    () async {
      await products.fetchAndSetProducts();
      setState(() => _loading = false);
    }();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themePref = Provider.of<ThemePreference>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Shop XD'),
        actions: <Widget>[
          // apply Consumer ONLY to the Badge, leave its children alone! :(((
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              value: cart.itemCount.toString(),
            ),
            // this child wont react to Cart changes, because its outside the builder!
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.route);
              },
            ),
          ),
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (ctx) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: "favorites",
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: "all",
              ),
              PopupMenuItem(
                child: Text('Toggle dark theme!'),
                value: "darkTheme",
              ),
            ],
            onSelected: (String val) {
              setState(() {
                switch (val) {
                  case "favorites":
                    showOnlyFavorites = true;
                    break;
                  case "all":
                    showOnlyFavorites = false;
                    break;
                  case "darkTheme":
                    themePref.isDarkTheme = !themePref.isDarkTheme;
                    break;
                }
              });
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(showOnlyFavorites),
    );
  }
}
