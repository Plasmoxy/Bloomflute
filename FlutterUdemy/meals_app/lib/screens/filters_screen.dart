import 'package:flutter/material.dart';
import 'package:meals_app/components/main_drawer.dart';
import 'package:meals_app/main.dart';

class FiltersScreen extends StatefulWidget {
  static const route = '/filters';

  final Function(MealFiltersObj) saveFilters;
  final MealFiltersObj filters;

  FiltersScreen(this.filters, this.saveFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  initState() {
    super.initState();
    _glutenFree = widget.filters.isGlutenFree;
    _vegetarian = widget.filters.isVegetarian;
    _vegan = widget.filters.isVegan;
    _lactoseFree = widget.filters.isLactoseFree;
  }

  Widget _switchListTile(String title, String subtitle, bool value, Function(bool) update) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: update,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              widget.saveFilters(
                MealFiltersObj(
                  isGlutenFree: _glutenFree,
                  isLactoseFree: _lactoseFree,
                  isVegan: _vegan,
                  isVegetarian: _vegetarian,
                ),
              );
            },
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(children: <Widget>[
        Container(
          padding: EdgeInsets.all(20),
          child: Text(
            'Adjust your meal selection:',
            style: Theme.of(context).textTheme.title,
          ),
        ),
        Expanded(
          child: ListView(children: <Widget>[
            _switchListTile(
              'Gluten-free',
              'Only include gluten-free meals.',
              _glutenFree,
              (x) => setState(() => _glutenFree = x),
            ),
            _switchListTile(
              'Lactose-free',
              'Only include lactose-free meals.',
              _lactoseFree,
              (x) => setState(() => _lactoseFree = x),
            ),
            _switchListTile(
              'Vegetarian',
              'Only include vegetarian meals.',
              _vegetarian,
              (x) => setState(() => _vegetarian = x),
            ),
            _switchListTile(
              'Vegan',
              'Only include vegan meals.',
              _vegan,
              (x) => setState(() => _vegan = x),
            ),
          ]),
        ),
      ]),
    );
  }
}
