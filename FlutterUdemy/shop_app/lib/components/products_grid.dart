import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/product_item.dart';
import 'package:shop_app/model/products.dart';

class ProductsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context);
    final items = products.items;

    return GridView.builder(
      padding: EdgeInsets.all(10),
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),

      // ChangeNotifierProvider disposes data automatically!
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: items[i],
        child: ProductItem(),
      ),
    );
  }
}
