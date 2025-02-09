import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  colorScheme: const ColorScheme(
    // Primary Colors
    primary: Color(0xFFFFC107), // Amber - Main brand color
    onPrimary: Color(0xFF000000), // Black text/icons on primary

    // Secondary Colors
    secondary: Color(0xFFFF9800), // Deep Orange - Accent color
    onSecondary: Color(0xFFFFFFFF), // White text/icons on secondary

    // Surface and Background
    surface: Color(0xFFFFFFFF), // White - Card/Dialog background
    onSurface: Color(0xFF000000), // Black text/icons on background

    // Error Colors
    error: Color(0xFFD32F2F), // Red - Error color
    onError: Color(0xFFFFFFFF), // White text/icons on error

    // Brightness
    brightness: Brightness.light,
  ),

  // AppBar Theme
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFFFC107), // Amber - Matches primary color
    foregroundColor: Color(0xFF000000), // Black - AppBar text/icon color
    elevation: 4, // Subtle shadow for depth
  ),

  // Elevated Button Theme
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: const Color(0xFF000000),
      backgroundColor: const Color(0xFFFFC107), // Black text on buttons
      elevation: 2, // Slight elevation for depth
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // Rounded corners
      ),
    ),
  ),

  // Text Theme
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 96, fontWeight: FontWeight.bold, color: Color(0xFF000000)),
    displayMedium: TextStyle(fontSize: 60, fontWeight: FontWeight.w600, color: Color(0xFF000000)),
    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Color(0xFF000000)),
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Color(0xFF616161)),
  ),

  // Input Decoration Theme
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFFF5F5F5), // Light gray background for inputs
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none, // No border for clean design
    ),
    hintStyle: const TextStyle(color: Color(0xFF9E9E9E)), // Gray placeholder text
  ),

  // Scaffold Background Color
  scaffoldBackgroundColor: const Color(0xFFF5F5F5), // Matches background color
);