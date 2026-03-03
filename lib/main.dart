import 'package:advanced_todo_app/core/app_theme.dart';
import 'package:advanced_todo_app/models/notes_model.dart';
import 'package:advanced_todo_app/models/todo_model.dart';
import 'package:advanced_todo_app/providers/navigation_provider.dart';
import 'package:advanced_todo_app/providers/notes_provider.dart';
import 'package:advanced_todo_app/providers/theme_provider.dart';
import 'package:advanced_todo_app/providers/todo_provider.dart';
import 'package:advanced_todo_app/screens/greeting_screen.dart';
import 'package:advanced_todo_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(NoteAdapter());
  Hive.registerAdapter(TodoAdapter());

  await Hive.openBox<Todo>("todos");
  await Hive.openBox<Note>("notes");
  await Hive.openBox("settings");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => NotesProvider()),
        ChangeNotifierProvider(create: (_) => TodoProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsBox = Hive.box('settings');
    final String? name = settingsBox.get("username");

    final themeProvider = context.watch<ThemeProvider>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.themeMode,
      routes: {"/home": (_) => const HomeScreen()},
      home: name == null ? GreetingScreen() : HomeScreen(),
    );
  }
}
