import 'package:advanced_todo_app/models/notes_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class NotesProvider extends ChangeNotifier {
  final Box<Note> notesBox = Hive.box<Note>("notes");

  List<Note> get notes => notesBox.values.toList();

  void addNote(String title, String body) {
    final newNote = Note(title: title, body: body);
    notesBox.add(newNote);
    notifyListeners();
  }

  void delNote(int index) {
    notesBox.deleteAt(index);
    notifyListeners();
  }

  void editNote(Note note, String newTitle, String newBody) {
    if (newTitle.trim().isEmpty || newBody.trim().isEmpty) return;

      note.title = newTitle.trim();
      note.body = newBody.trim();

      note.save();
      notifyListeners();

  }
}
