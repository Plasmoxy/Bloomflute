import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/model/products.dart';
import 'package:shop_app/screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String productId;
  final String title;
  final String imageUrl;

  UserProductItem(this.productId, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context, listen: false);

    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: imageUrl.isEmpty ? null : NetworkImage(imageUrl),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.edit, color: Theme.of(context).primaryColor),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.route, arguments: productId);
            },
          ),
          IconButton(
            icon: Icon(Icons.delete, color: Theme.of(context).errorColor),
            onPressed: () async {
              try {
                await products.deleteProduct(productId);
              } catch (error) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Deleting failed!'),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
