import 'package:advanced_todo_app/providers/todo_provider.dart';
import 'package:advanced_todo_app/widgets/todo_dialog.dart';
import 'package:advanced_todo_app/widgets/todo_tile.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  static List<List<dynamic>> todoList = [
    ["Todo Title", "Todo Description", false],
    ["Todo Title", "Todo Description", false],
  ];

  @override
  Widget build(BuildContext context) {
    final settingsBox = Hive.box('settings');
    final String? name = settingsBox.get("username");
    final todoProvider = context.watch<TodoProvider>();
    final todo = todoProvider.todo;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("Hello,", style: TextStyle(fontSize: 30)),
                      SizedBox(width: 5),
                      Text(
                        "${name.toString()}!",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Everything good?",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Your Todo",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade300,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => TodoDialog(),
                      );
                    },
                    icon: Icon(Icons.add, color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: todo.length,
                itemBuilder: (context, index) {
                  final todos = todo[index];
                  return TodoTile(
                    title: todos.title,
                    des: todos.description,
                    isDone: todos.isDone,
                    onTap: () => todoProvider.toggleTodo(todos),
                    
                    onDelete: () {
                      todoProvider.delTodo(todos);
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text("Todo Deleted!")));
                    }, todo: todos,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
