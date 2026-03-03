import 'package:advanced_todo_app/models/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/todo_provider.dart';

class TodoEditDialog extends StatefulWidget {
  final Todo todo;
  const TodoEditDialog({super.key, required this.todo});

  @override
  State<TodoEditDialog> createState() => _TodoDialogState();
}

class _TodoDialogState extends State<TodoEditDialog> {
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
  void initState() {
    super.initState();
    titleController.text = widget.todo.title;
    descController.text = widget.todo.description;

    // Optional: move cursor to end
    titleController.selection = TextSelection.fromPosition(
      TextPosition(offset: titleController.text.length),
    );
    descController.selection = TextSelection.fromPosition(
      TextPosition(offset: descController.text.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    final todoProvider = context.read<TodoProvider>();

    return AlertDialog(
      title: const Text("Edit Todo"),
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
                  todoProvider.editTodo(
                    widget.todo,
                    titleController.text,
                    descController.text,
                  );
                  Navigator.pop(context);
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text("Todo Updated!")));
                }
              },
              child: const Text("Edit Todo"),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
