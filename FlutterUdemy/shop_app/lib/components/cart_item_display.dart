import 'package:flutter/material.dart';
import 'package:shop_app/model/cart.dart';

class CartItemDisplay extends StatelessWidget {
  final CartItem item;

  CartItemDisplay(this.item);

  @override
  Widget build(BuildContext context) {
    return Card(
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
                child: Text('${item.price} €'),
              ),
            ),
          ),
          title: Text(item.title),
          subtitle: Text('Total: ${item.price * item.quantity} €'),
          trailing: Text('${item.quantity}x'),
        ),
      ),
    );
  }
}
