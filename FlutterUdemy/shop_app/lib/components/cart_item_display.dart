import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/model/cart.dart';

class CartItemDisplay extends StatelessWidget {
  // keep values as primitive as possible
  // = enables Flutter to reuse this widget because
  // its a stateless one
  final String id; // id of CartItem
  final String productId;
  final String title;
  final double price;
  final int quantity;

  CartItemDisplay(this.id, this.productId, this.title, this.price, this.quantity);

  @override
  Widget build(BuildContext context) {
    // only for writing state
    final cart = Provider.of<Cart>(context, listen: false);

    // Dismissible je stateful widget a preto potrebuje key!!!!!
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) => cart.removeItem(productId),
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: EdgeInsets.all(0),
          child: ListTile(
            leading: CircleAvatar(
              child: FittedBox(
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Text('$price €'),
                ),
              ),
            ),
            title: Text(title),
            subtitle: Text('Total: ${price * quantity} €'),
            trailing: Text('${quantity}x'),
          ),
        ),
      ),
    );
  }
}
