import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/apptheme.dart';
import 'package:shop_app/model/auth.dart';
import 'package:shop_app/model/cart.dart';
import 'package:shop_app/model/orders.dart';
import 'package:shop_app/model/products.dart';
import 'package:shop_app/model/theme_preference.dart';
import 'package:shop_app/screens/auth_screen.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/screens/product_detail_screen.dart';
import 'package:shop_app/screens/products_overview_screen.dart';
import 'package:shop_app/screens/user_products_screen.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // normal
        ChangeNotifierProvider(create: (_) => Auth()),
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => ThemePreference()),
        // proxy
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (_) => Products(),
          update: (_, auth, previous) => Products.update(previous, auth),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (_) => Orders(),
          update: (_, auth, previous) => Orders.update(previous, auth),
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) => Consumer<ThemePreference>(
          builder: (context, themePref, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Shop App',
            theme: themePref.isDarkTheme ? darkTheme : lightTheme,

            // init route, safer this way than using initialRoute
            // because initialRoute doesn't change conditionally
            // relative to consumers
            // really weird idk
            // Max says home is always checked when changing routes
            home: auth.isAuthenticated ? ProductsOverviewScreen() : AuthScreen(),

            // route generation for named Navigator pushes
            onGenerateRoute: (RouteSettings settings) {
              print('Building route: ${settings.name}.');
              final routes = <String, WidgetBuilder>{
                '/': (ctx) => ProductsOverviewScreen(),
                ProductDetailScreen.route: (ctx) => ProductDetailScreen(),
                CartScreen.route: (ctx) => CartScreen(),
                OrdersScreen.route: (ctx) => OrdersScreen(),
                UserProductsScreen.route: (ctx) => UserProductsScreen(),
                EditProductScreen.route: (ctx) => EditProductScreen(settings.arguments as String),
              };
              WidgetBuilder builder = routes[settings.name];
              // note: wrap builder call into another lambda in case of problems
              return MaterialPageRoute(builder: builder, settings: settings);
            },
          ),
        ),
      ),
    );
  }
}
