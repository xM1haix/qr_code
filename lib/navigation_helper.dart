import 'package:flutter/material.dart';

class NavigationHelper {
  final Widget page;
  final String title;
  final IconData _icon, _activeIcon;
  NavigationHelper({
    required this.title,
    required this.page,
    required IconData icon,
    required IconData activeIcon,
  })  : _activeIcon = activeIcon,
        _icon = icon;

  BottomNavigationBarItem get bottomNavigationBarItem =>
      BottomNavigationBarItem(
        label: "Scanner",
        icon: Icon(_icon),
        activeIcon: Icon(_activeIcon),
        tooltip: "Navigate to $title page",
      );
}
