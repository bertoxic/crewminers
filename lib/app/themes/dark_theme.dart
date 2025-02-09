import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  colorScheme: const ColorScheme(
    // Primary Colors
    primary: Color(0xFFFFB300), // Amber - Main brand color (slightly darker for contrast)
    onPrimary: Color(0xFF000000), // Black text/icons on primary

    // Secondary Colors
    secondary: Color(0xFFFF6F00), // Deep Orange - Accent color
    onSecondary: Color(0xFFFFFFFF), // White text/icons on secondary

    // Surface and Background
    surface: Color(0xFF121212), // Dark gray - Card/Dialog background
    onSurface: Color(0xFFFFFFFF), // White text/icons on background

    // Error Colors
    error: Color(0xFFCF6679), // Soft red - Error color (less harsh in dark mode)
    onError: Color(0xFF000000), // Black text/icons on error

    // Brightness
    brightness: Brightness.dark,
  ),

  // AppBar Theme
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF1E1E1E), // Matches background color
    foregroundColor: Color(0xFFFFFFFF), // White - AppBar text/icon color
    elevation: 4, // Subtle shadow for depth
  ),

  // Elevated Button Theme
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: const Color(0xFF000000),
      backgroundColor: const Color(0xFFFFB300), // Black text on buttons
      elevation: 2, // Slight elevation for depth
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // Rounded corners
      ),
    ),
  ),

  // Text Theme
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 96, fontWeight: FontWeight.bold, color: Color(0xFFFFFFFF)),
    displayMedium: TextStyle(fontSize: 60, fontWeight: FontWeight.w600, color: Color(0xFFFFFFFF)),
    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Color(0xFFFFFFFF)),
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Color(0xFFBDBDBD)),
  ),

  // Input Decoration Theme
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFF2C2C2C), // Darker gray background for inputs
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none, // No border for clean design
    ),
    hintStyle: const TextStyle(color: Color(0xFF616161)), // Gray placeholder text
  ),

  // Scaffold Background Color
  scaffoldBackgroundColor: const Color(0xFF1E1E1E), // Matches background color
);