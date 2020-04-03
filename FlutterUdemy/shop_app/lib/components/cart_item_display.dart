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
  final String imageUrl;

  CartItemDisplay(this.id, this.productId, this.title, this.price, this.quantity, this.imageUrl);

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
      confirmDismiss: (direction) => showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Are you sure about that?'),
          content: Text('Nibba do u rly want to remove from cart??'),
          actions: <Widget>[
            FlatButton(
                child: Text('NO.,'),
                onPressed: () {
                  // showDialog returns the future of navigator pop
                  Navigator.of(ctx).pop(false);
                }),
            FlatButton(
                child: Text('Y E S'),
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                }),
          ],
        ),
      ),
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: EdgeInsets.all(0),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: imageUrl.isNotEmpty ? NetworkImage(imageUrl) : null,
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
