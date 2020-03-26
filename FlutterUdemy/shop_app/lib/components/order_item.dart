import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/model/orders.dart';

class OrderItem extends StatelessWidget {
  final ShopOrder order;

  OrderItem(this.order);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(children: <Widget>[
        ListTile(
          title: Text('${order.total} €'),
          subtitle: Text(
            DateFormat('dd.MM.yyyy').format(order.dateTime),
          ),
          trailing: IconButton(
            icon: Icon(Icons.expand_more),
            onPressed: () {},
          ),
        )
      ]),
    );
  }
}
