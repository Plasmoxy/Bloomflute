import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class ThemePreference with ChangeNotifier {
  bool _darkTheme;

  get isDarkTheme => _darkTheme;
  set isDarkTheme(bool dark) {
    _darkTheme = dark;
    notifyListeners();
  }

  ThemePreference() {
    _darkTheme = WidgetsBinding.instance.window.platformBrightness == Brightness.dark;
  }
}
