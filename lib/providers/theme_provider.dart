import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ThemeProvider extends ChangeNotifier {
  final Box settingsBox = Hive.box('settings');

  late ThemeMode _themeMode;

  ThemeProvider() {
    bool isDark = settingsBox.get('isDark', defaultValue: false);
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
  }

  ThemeMode get themeMode => _themeMode;

  void toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    settingsBox.put('isDark', isDark);
    notifyListeners();
  }
}