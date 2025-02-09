// app.dart
import 'package:flutter/material.dart';
import 'package:minner/core/utils/responsive/responsive_sizes.dart';

class MinnerApp extends StatefulWidget {
   const MinnerApp({super.key});

  @override
  _MinnerAppState createState() => _MinnerAppState();
}

class _MinnerAppState extends State<MinnerApp> {
  int _selectedIndex = 0; // Tracks the currently selected tab

  // List of pages for navigation
  final List<Widget> _pages = [

  ];

  // Callback for bottom navigation bar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter App'), // Dynamic title based on the current page
      ),
      body: _pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items:  <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 20.sp,),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, size: 20.sp,),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}




