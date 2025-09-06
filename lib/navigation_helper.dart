import "package:flutter/material.dart";

class NavigationHelper {
  NavigationHelper({
    required this.title,
    required this.page,
    required IconData icon,
    required IconData activeIcon,
  })  : _activeIcon = activeIcon,
        _icon = icon;
  final Widget page;
  final String title;
  final IconData _icon;
  final IconData _activeIcon;

  BottomNavigationBarItem get bottomNavigationBarItem =>
      BottomNavigationBarItem(
        label: "Scanner",
        icon: Icon(_icon),
        activeIcon: Icon(_activeIcon),
        tooltip: "Navigate to $title page",
      );
}
