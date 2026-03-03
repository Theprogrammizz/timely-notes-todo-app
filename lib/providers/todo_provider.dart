import 'package:advanced_todo_app/models/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class TodoProvider extends ChangeNotifier {
  final Box<Todo> todosBox = Hive.box<Todo>("todos");

  List<Todo> get todo => todosBox.values.toList();

  void addTodo(String title, String description) {
    if (title.isEmpty || description.isEmpty) return;
    final newTodo = Todo(title: title, description: description);
    todosBox.add(newTodo);
    notifyListeners();
  }

  void delTodo(Todo todo) {
    todo.delete();
    notifyListeners();
  }

  void toggleTodo(Todo todo) {
    todo.isDone = !todo.isDone;
    todo.save();
    notifyListeners();
  }

  void editTodo(Todo todo, String updatedTitle, String updatedDes) {
    if (updatedTitle.isEmpty || updatedDes.isEmpty) return;

    todo.title = updatedTitle;
    todo.description = updatedDes;

    todo.save();
    notifyListeners();
  }
}
