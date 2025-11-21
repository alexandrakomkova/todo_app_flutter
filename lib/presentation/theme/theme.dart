import 'package:flutter/material.dart';

class TodoTheme {

  static Gradient backgroundTodoCardCompletedLight = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Colors.green.shade200, Colors.blue.shade200],
  );

  static Gradient backgroundTodoCardUnCompletedLight = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Colors.red.shade200, Colors.purple.shade200],
    );

  static Gradient backgroundTodoCardCompletedDark = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Colors.green.shade700, Colors.blue.shade900],
    );

  static Gradient backgroundTodoCardUnCompletedDark = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Colors.red.shade800, Colors.purple.shade900],
    );

  static ThemeData light = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.light,
        seedColor: Colors.deepPurple
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
    );

  static ThemeData dark = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: Colors.deepPurple,
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
    );
}
