import 'package:flutter/material.dart';
import 'package:great_places/screens/add_place.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.route);
            },
          ),
        ],
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
