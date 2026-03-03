import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    final settingsBox = Hive.box('settings');
    nameController.text = settingsBox.get("username", defaultValue: "");
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    bool isDark = themeProvider.themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(title: const Text("Settings"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Name"),
                validator: (value) => value == null || value.trim().isEmpty
                    ? "Name cannot be empty"
                    : null,
              ),
            ),
            const SizedBox(height: 10),
            FilledButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final settingsBox = Hive.box('settings');
                  settingsBox.put("username", nameController.text.trim());
                }
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text("Name Updated")));
              },
              child: const Text("Update Name"),
            ),

            const SizedBox(height: 30),
            ListTile(
              title: Text("Dark Mode"),
              trailing: Switch(
                value: isDark,
                onChanged: (value) {
                  themeProvider.toggleTheme(value);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
