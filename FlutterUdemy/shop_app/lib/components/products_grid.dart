import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/product_item.dart';
import 'package:shop_app/model/products.dart';

class ProductsGrid extends StatelessWidget {
  final bool showOnlyFavorites;

  ProductsGrid(this.showOnlyFavorites);

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context);
    final displayItems = showOnlyFavorites ? products.favoriteItems : products.items;

    return GridView.builder(
      padding: EdgeInsets.all(10),
      itemCount: displayItems.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),

      // ChangeNotifierProvider disposes data automatically!
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: displayItems[i],
        child: ProductItem(),
      ),
    );
  }
}
