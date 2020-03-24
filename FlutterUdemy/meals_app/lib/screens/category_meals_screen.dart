import 'package:flutter/material.dart';
import 'package:meals_app/components/meal_item.dart';
import 'package:meals_app/model/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const route = '/category-meals';

  final List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  List<Meal> displayedMeals;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (displayedMeals == null) {
      final routeArgs = ModalRoute.of(context).settings.arguments as Map<String, String>;
      final categoryId = routeArgs['id'];
      categoryTitle = routeArgs['title'];

      displayedMeals = widget.availableMeals.where((x) => x.categories.contains(categoryId)).toList();
    }
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(categoryTitle)),
      body: ListView.builder(
        itemBuilder: (ctx, idx) {
          return MealItem(displayedMeals[idx], _removeMeal);
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
