import 'package:flutter/material.dart';
import 'package:meals_app/components/meal_item.dart';
import 'package:meals_app/model/meal.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favMeals;

  FavoritesScreen(this.favMeals);

  @override
  Widget build(BuildContext context) {
    if (favMeals.isEmpty)
      return Center(
        child: Text('No favorites yet!'),
      );
    else {
      return ListView.builder(
        itemBuilder: (ctx, idx) {
          return MealItem(favMeals[idx]);
        },
        itemCount: favMeals.length,
      );
    }
  }
}
