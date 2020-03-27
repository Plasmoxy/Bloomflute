import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/cart_item_display.dart';
import 'package:shop_app/model/cart.dart';
import 'package:shop_app/model/orders.dart';
import 'package:shop_app/model/products.dart';

class CartScreen extends StatelessWidget {
  static const route = "/cart-screen";

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final products = Provider.of<Products>(context, listen: false);
    final orders = Provider.of<Orders>(context, listen: false);

    final cartItems = cart.items.values.toList();
    final productIds = cart.items.keys.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Column(children: <Widget>[
        Card(
          elevation: 3,
          margin: EdgeInsets.all(15),
          child: Padding(
            padding: EdgeInsets.all(7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Total:', style: TextStyle(fontSize: 20)),
                Spacer(),
                Chip(
                  label: Text(
                    '${cart.totalSum.toStringAsFixed(2)} €',
                    style: TextStyle(
                      color: Theme.of(context).primaryTextTheme.title.color,
                    ),
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                FlatButton(
                  child: Text('ORDER NOW'),
                  textColor: Theme.of(context).primaryColor,
                  onPressed: () {
                    orders.addOrder(cartItems, cart.totalSum);
                    cart.clear();
                  },
                ),
              ],
            ),
          ),
        ),
        Text('(Swipe to remove item from cart)'),
        SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            itemCount: cart.itemCount,
            itemBuilder: (ctx, i) => CartItemDisplay(
              cartItems[i].id,
              productIds[i],
              cartItems[i].title,
              cartItems[i].price,
              cartItems[i].quantity,
              products.findById(productIds[i]).imageUrl,
            ),
          ),
        ),
      ]),
    );
  }
}
