import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/app_drawer.dart';
import 'package:shop_app/components/user_product_item.dart';
import 'package:shop_app/model/products.dart';
import 'package:shop_app/screens/edit_product_screen.dart';

class UserProductsScreen extends StatelessWidget {
  static const route = '/user-products';

  Future<void> _refresh(BuildContext ctx) async {
    await Provider.of<Products>(ctx, listen: false).fetchAndSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your products'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.route);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: _refresh(context),
        builder: (_, snapshot) => snapshot.connectionState == ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                color: Theme.of(context).canvasColor,
                backgroundColor: Theme.of(context).accentColor,
                onRefresh: () => _refresh(context),
                child: Consumer<Products>(
                  builder: (ctx, products, _) => ListView.builder(
                    padding: EdgeInsets.all(10),
                    itemCount: products.items.length,
                    itemBuilder: (bctx, i) => Column(children: <Widget>[
                      UserProductItem(
                        products.items[i].id,
                        products.items[i].title,
                        products.items[i].imageUrl,
                      ),
                      Divider(),
                    ]),
                  ),
                ),
              ),
      ),
      drawer: AppDrawer(),
    );
  }
}
