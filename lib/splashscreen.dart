import 'package:flutter/material.dart';
import 'package:qr_code/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.black,
        body: FutureBuilder(
          future: nav(),
          builder: (context, snapshot) => const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF5BE727),
            ),
          ),
        ),
      );

  Future nav() async => await Future.delayed(const Duration(seconds: 1)).then(
        (_) => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const Home(),
          ),
        ),
      );
}
