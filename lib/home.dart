import "package:flutter/material.dart";
import "package:qr_code/history_page.dart";
import "package:qr_code/navigation_helper.dart";
import "package:qr_code/scanner_page.dart";
import "package:qr_code/settings_page.dart";

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _index = 0;
  final _data = [
    NavigationHelper(
      title: "Scanner",
      page: const ScannerPage(),
      icon: Icons.camera_alt_outlined,
      activeIcon: Icons.camera_alt,
    ),
    NavigationHelper(
      title: "History",
      page: const HistoryPage(),
      icon: Icons.history_outlined,
      activeIcon: Icons.history,
    ),
    NavigationHelper(
      title: "Settings",
      page: const SettingsPage(),
      icon: Icons.settings_outlined,
      activeIcon: Icons.settings,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_data[_index].title),
      ),
      body: _data[_index].page,
      bottomNavigationBar: BottomNavigationBar(
        selectedIconTheme: const IconThemeData(size: 40),
        showUnselectedLabels: false,
        currentIndex: _index,
        selectedItemColor: Colors.blue,
        items: _data.map((e) => e.bottomNavigationBarItem).toList(),
        onTap: (x) => setState(() {
          _index = x;
        }),
      ),
    );
  }
}
