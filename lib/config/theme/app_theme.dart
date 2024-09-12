import 'package:flutter/material.dart';

class AppTheme {
  // Tema claro
  ThemeData getLightTheme() => ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.light, // Tema claro
      );

  // Tema oscuro
  ThemeData getDarkTheme() => ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.dark, // Tema oscuro
        
      );
}
