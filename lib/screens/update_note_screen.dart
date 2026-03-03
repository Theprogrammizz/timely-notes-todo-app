import 'package:advanced_todo_app/models/notes_model.dart';
import 'package:advanced_todo_app/providers/notes_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateNoteScreen extends StatefulWidget {
  final Note note;
  const UpdateNoteScreen({super.key, required this.note});

  @override
  State<UpdateNoteScreen> createState() => _UpdateNoteScreenState();
}

class _UpdateNoteScreenState extends State<UpdateNoteScreen> {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.note.title;
    bodyController.text = widget.note.body;

    bodyController.selection = TextSelection.fromPosition(
      TextPosition(offset: bodyController.text.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    final noteProvider = context.read<NotesProvider>();
    return Scaffold(
      appBar: AppBar(title: Text("Update Note"), centerTitle: true),
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
                  noteProvider.editNote(
                    widget.note,
                    titleController.text,
                    bodyController.text,
                  );
                  titleController.clear();
                  bodyController.clear();
                  Navigator.of(context).pop();

                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("Note Updated")));
                }
              },
              child: Text("Update Note"),
            ),
          ],
        ),
      ),
    );
  }
}
