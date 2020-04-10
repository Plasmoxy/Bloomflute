import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:great_places/helpers/db_helper.dart';
import 'package:great_places/model/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items => [..._items];

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DB.getData('user_places');
    _items = dataList
        .map((item) => Place(
              id: item['id'],
              title: item['title'],
              image: File(item['image']),
              location: null,
            ))
        .toList();
    notifyListeners();
  }

  void add(String title, File image) {
    final place = Place(
      id: DateTime.now().toString(),
      image: image,
      title: title,
      location: null,
    );

    _items.add(place);
    notifyListeners();

    DB.insert('user_places', {
      'id': place.id,
      'title': place.title,
      'image': place.image.path,
    });
  }
}
