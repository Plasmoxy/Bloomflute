import 'package:flutter/material.dart';
import 'package:meals_app/model/meal.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favMeals;

  FavoritesScreen(this.favMeals);

  @override
  Widget build(BuildContext context) {
    return Text('Favorites');
  }
}
