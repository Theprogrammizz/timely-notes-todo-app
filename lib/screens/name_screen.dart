import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class NameScreen extends StatefulWidget {
  const NameScreen({super.key});

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  final TextEditingController _controller = TextEditingController();
  final Box settingsBox = Hive.box('settings');

  void saveName() {
    String name = _controller.text.trim();

    if (name.isEmpty) return;

    settingsBox.put("username", name);

    Navigator.of(context).pushNamed("/home");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("What's your name?", style: TextStyle(fontSize: 22)),
            const SizedBox(height: 20),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter your name",
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: saveName, child: const Text("Continue")),
          ],
        ),
      ),
    );
  }
}
