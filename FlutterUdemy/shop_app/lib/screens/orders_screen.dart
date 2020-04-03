import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/app_drawer.dart';
import 'package:shop_app/components/order_item.dart';
import 'package:shop_app/model/orders.dart';

class OrdersScreen extends StatelessWidget {
  static const route = "/orders";

  @override
  Widget build(BuildContext context) {
    // WARNING: setting up a provider listener here
    // is bad because we are using FutureBuilder
    // = futurebuilder will launch the async method which
    // will notify listeners including this one
    // it is ok to run it like this,
    // but if we really want to listen to provider state
    // we add Consumer
    final orders = Provider.of<Orders>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your orders'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: orders.fetchAndSetOrders(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // waiting
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.error != null) {
            // error
            return Text('Error occured');
          } else {
            // success
            return Consumer<Orders>(
              builder: (ctx, consumed, _) => ListView.builder(
                itemCount: consumed.orders.length,
                itemBuilder: (ctx, i) => OrderItem(consumed.orders[i]),
              ),
            );
          }
        },
      ),
    );
  }
}
