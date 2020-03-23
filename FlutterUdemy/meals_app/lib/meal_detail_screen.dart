import 'package:flutter/material.dart';
import 'package:meals_app/model/meal.dart';

class MealDetailScreen extends StatelessWidget {
  static const route = '/meal-detail';

  Widget _buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.title,
      ),
    );
  }

  Widget _buildDisplayContainer(Widget child) {
    return Container(
      height: 200,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final meal = ModalRoute.of(context).settings.arguments as Meal;
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Container(
            height: 300,
            width: double.infinity,
            child: Image.network(
              meal.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          _buildSectionTitle(context, "Ingredients"),
          _buildDisplayContainer(ListView.builder(
            itemCount: meal.ingredients.length,
            itemBuilder: (ctx, index) => Card(
              color: Theme.of(context).accentColor,
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Text(meal.ingredients[index]),
              ),
            ),
          )),
          _buildSectionTitle(context, "Steps"),
          _buildDisplayContainer(ListView.builder(
            itemCount: meal.ingredients.length,
            itemBuilder: (ctx, index) => Column(
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(
                    child: Text('${index + 1}'),
                  ),
                  title: Text(meal.steps[index]),
                ),
                Divider(),
              ],
            ),
          )),
        ]),
      ),
    );
  }
}
