import 'package:flutter/material.dart';
import 'package:great_places/model/great_places.dart';
import 'package:great_places/screens/add_place.dart';
import 'package:great_places/screens/places_list.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GreatPlaces()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.orange,
        ),
        home: PlacesListScreen(),
        onGenerateRoute: (settings) {
          print("-> ${settings.name}");

          final routes = {
            AddPlaceScreen.route: (ctx) => AddPlaceScreen(),
          };
          return MaterialPageRoute(
            settings: settings,
            builder: routes[settings.name] ?? (_) => PlacesListScreen(),
          );
        },
      ),
    );
  }
}
