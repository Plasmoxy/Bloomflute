import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:great_places/model/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items => [..._items];

  void add(String title, File image) {
    _items.add(Place(
      id: DateTime.now().toString(),
      image: image,
      title: title,
      location: null,
    ));
    notifyListeners();
  }
}
