import 'package:advanced_todo_app/providers/notes_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});
  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final noteProvider = context.read<NotesProvider>();
    return Scaffold(
      appBar: AppBar(title: Text("Add Note"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: titleController,
                      decoration: const InputDecoration(labelText: "Title"),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Title cannot be empty!";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: bodyController,
                      decoration: const InputDecoration(
                        labelText: "Body",
                        alignLabelWithHint: true,
                      ),
                      maxLines: null,
                      minLines: 5,
                      textInputAction: TextInputAction.newline,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Body cannot be empty!";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            FilledButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  noteProvider.addNote(
                    titleController.text.trim(),
                    bodyController.text.trim(),
                  );
                  titleController.clear();
                  bodyController.clear();
                  Navigator.of(context).pop();

                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("Note Added")));
                }
              },
              child: Text("Add Note"),
            ),
          ],
        ),
      ),
    );
  }
}
