import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/todo_provider.dart';

class TodoDialog extends StatefulWidget {
  const TodoDialog({super.key});

  @override
  State<TodoDialog> createState() => _TodoDialogState();
}

class _TodoDialogState extends State<TodoDialog> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final todoProvider = context.read<TodoProvider>();

    return AlertDialog(
      title: const Text("Add Todo"),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Title"),
              validator: (value) => value == null || value.trim().isEmpty
                  ? "Title cannot be empty"
                  : null,
            ),

            const SizedBox(height: 10),

            TextFormField(
              controller: descController,
              decoration: const InputDecoration(labelText: "Description"),
              minLines: 2,
              maxLines: null,
              validator: (value) => value == null || value.trim().isEmpty
                  ? "Description cannot be empty"
                  : null,
            ),

            const SizedBox(height: 20),

            FilledButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  todoProvider.addTodo(
                    titleController.text.trim(),
                    descController.text.trim(),
                  );

                  Navigator.pop(context);
                }
              },
              child: const Text("Add Todo"),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
