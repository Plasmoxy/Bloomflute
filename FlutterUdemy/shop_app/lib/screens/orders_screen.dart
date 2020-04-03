import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/app_drawer.dart';
import 'package:shop_app/components/order_item.dart';
import 'package:shop_app/model/orders.dart';

class OrdersScreen extends StatefulWidget {
  static const route = "/orders";

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _loading = false;

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      final orders = Provider.of<Orders>(context, listen: false);

      setState(() => _loading = true);
      await orders.fetchAndSetOrders();
      setState(() => _loading = false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your orders'),
      ),
      drawer: AppDrawer(),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: orders.orders.length,
              itemBuilder: (ctx, i) => OrderItem(orders.orders[i]),
            ),
    );
  }
}
