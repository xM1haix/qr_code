import "package:flutter/material.dart";
import "package:qr_code/home.dart";

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

ThemeData _generateThemeData(bool isDark) => ThemeData(
      brightness: isDark ? Brightness.dark : Brightness.light,
      appBarTheme: const AppBarTheme(centerTitle: true),
    );

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _generateThemeData(false),
      darkTheme: _generateThemeData(true),
      home: const Home(),
    );
  }
}
