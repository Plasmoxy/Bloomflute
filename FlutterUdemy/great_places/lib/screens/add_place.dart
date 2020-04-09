import 'package:flutter/material.dart';

class AddPlaceScreen extends StatefulWidget {
  static const route = "/add-place";

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New place'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text('User Inputs ..'),
          RaisedButton.icon(
            icon: Icon(Icons.add),
            label: Text('Add Place'),
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Theme.of(context).accentColor,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
