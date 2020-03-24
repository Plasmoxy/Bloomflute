import 'package:flutter/material.dart';
import 'package:meals_app/model/meal.dart';
import 'package:meals_app/model/mockdata.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/category_meals_screen.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meal_detail_screen.dart';
import 'package:meals_app/screens/tabs_screen.dart';

void main() => runApp(MyApp());

class MealFiltersObj {
  bool isGlutenFree = false;
  bool isLactoseFree = false;
  bool isVegan = false;
  bool isVegetarian = false;
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var filters = MealFiltersObj();
  List<Meal> availableMeals = DUMMY_MEALS;

  void saveFilters(MealFiltersObj newFilters) {
    setState(() {
      filters = newFilters;
      availableMeals = DUMMY_MEALS;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      primarySwatch: Colors.pink,
      accentColor: Colors.amber,
      fontFamily: 'Raleway',
      // canvasColor: Color(0xff101013),
      textTheme: ThemeData.light().textTheme.copyWith(
            body1: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            body2: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            title: TextStyle(
              fontSize: 20,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            ),
          ),
    );

    return MaterialApp(
      title: 'Meals App',
      theme: theme,
      initialRoute: '/', // default je '/'
      routes: {
        '/': (ctx) => TabsScreen(),
        CategoryMealsScreen.route: (ctx) => CategoryMealsScreen(availableMeals),
        MealDetailScreen.route: (ctx) => MealDetailScreen(),
        FiltersScreen.route: (ctex) => FiltersScreen(saveFilters),
      },
      // onGenerateRoute: (settings) {
      //   print(settings.arguments);
      //   return MaterialPageRoute(
      //     builder: (ctx) => CategoriesScreen(),
      //   );
      // },

      // 404 fallback page
      onUnknownRoute: (setings) {
        return MaterialPageRoute(
          builder: (ctx) => CategoriesScreen(),
        );
      },
    );
  }
}
