import 'package:flutter/material.dart';
import 'package:meals_app/components/main_drawer.dart';

class FiltersScreen extends StatelessWidget {
  static const route = '/filters';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
      ),
      drawer: MainDrawer(),
      body: Text("yosh"),
    );
  }
}
