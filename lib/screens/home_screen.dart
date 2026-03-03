import 'package:advanced_todo_app/providers/navigation_provider.dart';
import 'package:advanced_todo_app/screens/main_app_screen.dart';
import 'package:advanced_todo_app/screens/setting_screen.dart';
import 'package:advanced_todo_app/screens/todo_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationProvider>(
      builder: (context, value, child) {
        final screen = [MainAppScreen(), TodoScreen(), SettingScreen()];

        return Scaffold(
          body: IndexedStack(index: value.currentIndex, children: screen),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: value.currentIndex,
            onTap: (index) {
              value.changeIndex(index);
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.list), label: "Todo"),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: "Settings",
              ),
            ],
          ),
        );
      },
    );
  }
}
