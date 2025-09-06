import "package:flutter/material.dart";

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: _controller,
      child: ListView(
        controller: _controller,
        children: [
          ListTile(
            onTap: () {},
            title: const Text("Theme mode"),
          ),
          ListTile(
            onTap: () async {},
            title: const Text("Clean history?"),
          ),
        ],
      ),
    );
  }
}
