import 'package:flutter/material.dart';
import 'model/mockdata.dart';

class CategoryMealsScreen extends StatelessWidget {
  static const route = '/category-meals';
  // final String categoryId;
  // final String categoryTitle;

  // CategoryMealsScreen(this.categoryId, this.categoryTitle);

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final categoryTitle = routeArgs['title'];
    final categoryId = routeArgs['id'];

    final filteredMeals = DUMMY_MEALS
        .where(
          (x) => x.categories.contains(categoryId),
        )
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text(categoryTitle)),
      body: ListView.builder(
        itemBuilder: (ctx, idx) {
          return Text(filteredMeals[idx].title);
        },
        itemCount: filteredMeals.length,
      ),
    );
  }
}
