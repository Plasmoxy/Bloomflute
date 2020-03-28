import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/apptheme.dart';
import 'package:shop_app/model/cart.dart';
import 'package:shop_app/model/orders.dart';
import 'package:shop_app/model/products.dart';
import 'package:shop_app/model/theme_preference.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/screens/product_detail_screen.dart';
import 'package:shop_app/screens/products_overview_screen.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Products()),
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => Orders()),
        ChangeNotifierProvider(create: (_) => ThemePreference()),
      ],
      child: Consumer<ThemePreference>(
        builder: (context, themePref, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Shop App',
          theme: themePref.isDarkTheme ? darkTheme() : lightTheme(),
          routes: {
            '/': (ctx) => ProductsOverviewScreen(),
            ProductDetailScreen.route: (ctx) => ProductDetailScreen(),
            CartScreen.route: (ctx) => CartScreen(),
            OrdersScreen.route: (ctx) => OrdersScreen(),
          },
        ),
      ),
    );
  }
}
