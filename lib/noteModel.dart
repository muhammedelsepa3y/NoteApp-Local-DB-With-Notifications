import 'package:flutter/material.dart';

class Note {
  final String title;
  final String content;

  Note({required this.title, required this.content});
}

class NoteProvider extends ChangeNotifier {
  List<Note> _notes = [
    Note(title: 'Note 1', content: 'Content of Note 1'),
    Note(title: 'Note 2', content: 'Content of Note 2'),
    Note(title: 'Note 3', content: 'Content of Note 3'),
    Note(title: 'Note 4', content: 'Content of Note 4'),
    Note(title: 'Note 5', content: 'Content of Note 5'),
    Note(title: 'Note 6', content: 'Content of Note 6'),
    Note(title: 'Note 7', content: 'Content of Note 7'),


    // Add more notes...
  ];

  List<Note> get notes => _notes;

  List<Note> searchNotes(String query) {
    return _notes
        .where((note) =>
    note.title.toLowerCase().contains(query.toLowerCase()) ||
        note.content.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
  void addNote(Note note) {
    _notes.add(note);
    notifyListeners();
  }

  void editNote(int index, Note updatedNote) {
    _notes[index] = updatedNote;
    notifyListeners();
  }

  void deleteNote(int index) {
    _notes.removeAt(index);
    notifyListeners();
  }
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
