import 'package:flutter/material.dart';
import 'package:meals_app/screens/meal_detail_screen.dart';
import 'package:meals_app/model/meal.dart';

class MealItem extends StatelessWidget {
  final Meal meal;
  final void Function(String id) removeItem;

  MealItem(this.meal, this.removeItem);

  void selected(BuildContext context) async {
    final result = await Navigator.of(context).pushNamed(
      MealDetailScreen.route,
      arguments: meal,
    );
    if (result != null) {
      removeItem(result);
    }
  }

  String get complexityText {
    switch (meal.complexity) {
      case Complexity.Simple:
        return 'Simple';
      case Complexity.Challenging:
        return 'Challenging';
      case Complexity.Hard:
        return 'Hard';
      default:
        return 'Unknown';
    }
  }

  String get affordabilityText {
    switch (meal.affordability) {
      case Affordability.Affordable:
        return 'Affordable';
      case Affordability.Pricey:
        return 'Pricey';
      case Affordability.Luxurious:
        return 'Luxurious';
      default:
        return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selected(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Column(children: <Widget>[
          Stack(children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              child: Image.network(
                meal.imageUrl,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 20,
              left: 10,
              child: Container(
                width: 270,
                padding: EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  meal.title,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                  softWrap: true,
                  overflow: TextOverflow.fade,
                ),
              ),
            ),
          ]),
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(children: <Widget>[
                  Icon(Icons.schedule),
                  SizedBox(width: 6),
                  Text('${meal.duration} min'),
                ]),
                Row(children: <Widget>[
                  Icon(Icons.work),
                  SizedBox(width: 6),
                  Text(complexityText),
                ]),
                Row(children: <Widget>[
                  Icon(Icons.attach_money),
                  SizedBox(width: 6),
                  Text(affordabilityText),
                ]),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
