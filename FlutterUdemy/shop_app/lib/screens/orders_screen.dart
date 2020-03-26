import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/order_item.dart';
import 'package:shop_app/model/orders.dart';

class OrdersScreen extends StatelessWidget {
  static const route = "/orders";

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your orders'),
      ),
      body: ListView.builder(
        itemCount: orders.orders.length,
        itemBuilder: (ctx, i) => OrderItem(orders.orders[i]),
      ),
    );
  }
}
