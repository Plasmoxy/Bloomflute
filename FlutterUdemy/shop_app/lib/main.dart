import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/model/cart.dart';
import 'package:shop_app/model/orders.dart';
import 'package:shop_app/model/products.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/screens/product_detail_screen.dart';
import 'package:shop_app/screens/products_overview_screen.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Products>.value(value: Products()),
        ChangeNotifierProvider<Cart>.value(value: Cart()),
        ChangeNotifierProvider<Orders>.value(value: Orders()),
      ],
      child: MaterialApp(
        title: 'Shop App',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          accentColor: Colors.deepPurpleAccent,
          fontFamily: 'Lato',
        ),
        routes: {
          '/': (ctx) => ProductsOverviewScreen(),
          ProductDetailScreen.route: (ctx) => ProductDetailScreen(),
          CartScreen.route: (ctx) => CartScreen(),
          OrdersScreen.route: (ctx) => OrdersScreen(),
        },
      ),
    );
  }
}
