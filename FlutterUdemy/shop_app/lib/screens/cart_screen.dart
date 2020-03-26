import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/cart_item_display.dart';
import 'package:shop_app/model/cart.dart';

class CartScreen extends StatelessWidget {
  static const route = "/cart-screen";

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final values = cart.items.values.toList();
    final keys = cart.items.keys.toList();

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
                    '${cart.totalSum} €',
                    style: TextStyle(
                      color: Theme.of(context).primaryTextTheme.title.color,
                    ),
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                FlatButton(
                  child: Text('ORDER NOW'),
                  textColor: Theme.of(context).primaryColor,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            itemCount: cart.itemCount,
            itemBuilder: (ctx, i) => CartItemDisplay(
              values[i].id,
              keys[i],
              values[i].title,
              values[i].price,
              values[i].quantity,
            ),
          ),
        ),
      ]),
    );
  }
}
