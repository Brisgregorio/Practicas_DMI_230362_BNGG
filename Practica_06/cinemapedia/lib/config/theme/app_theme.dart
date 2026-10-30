


import 'package:flutter/material.dart';

const List<Color> colorList = [
  Colors.blue,
  Colors.teal,
  Colors.green,
  Colors.purple,
  Colors.orange,
  Colors.red,
  Colors.brown,
  Colors.indigo,
];

class AppTheme {
  final bool isDarkmode;
  final int selectedColor;

  AppTheme({
    this.isDarkmode = false,
    this.selectedColor = 0,
  });

  AppTheme copyWith({
    bool? isDarkmode,
    int? selectedColor,
  }) {
    return AppTheme(
      isDarkmode: isDarkmode ?? this.isDarkmode,
      selectedColor: selectedColor ?? this.selectedColor,
    );
  }

  ThemeData getTheme() {
    final seedColor = colorList[selectedColor.clamp(0, colorList.length - 1)];

    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: isDarkmode ? Brightness.dark : Brightness.light,
      ),
    );
  }
}