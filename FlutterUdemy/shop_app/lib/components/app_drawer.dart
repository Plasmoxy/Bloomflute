import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/model/auth.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/screens/user_products_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: <Widget>[
        AppBar(
          title: Text('Yosh welcome.'),
          automaticallyImplyLeading: false,
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.shop),
          title: Text('Shop'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/');
          },
        ),
        ListTile(
          leading: Icon(Icons.payment),
          title: Text('Orders'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed(OrdersScreen.route);
          },
        ),
        ListTile(
          leading: Icon(Icons.edit),
          title: Text('Manage products'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed(UserProductsScreen.route);
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text('Log out'),
          onTap: () {
            Navigator.of(context).pop(); // CLOSE DRAWER FIRST!
            Provider.of<Auth>(context, listen: false).logout();
          },
        ),
      ]),
    );
  }
}
