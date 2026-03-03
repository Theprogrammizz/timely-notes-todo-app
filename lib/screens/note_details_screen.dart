import 'package:advanced_todo_app/models/notes_model.dart';
import 'package:advanced_todo_app/screens/update_note_screen.dart';
import 'package:flutter/material.dart';

class NoteDetailScreen extends StatelessWidget {
  final String title;
  final String content;
  final Note note;

  const NoteDetailScreen({
    super.key,
    required this.title,
    required this.content,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return UpdateNoteScreen(note: note);
                  },
                ),
              );
            },
            icon: Icon(Icons.edit),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(content, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
