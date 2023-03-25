import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'models.dart';

const String dbName = 'Notes Database';

ValueNotifier<List<NotesModel>> notesModelNotifier = ValueNotifier([]);

//Note Table

class NotesDbFunctions {
  NotesDbFunctions.internals();
  static NotesDbFunctions instance = NotesDbFunctions.internals();
  factory NotesDbFunctions() {
    return instance;
  }

  Future<void> createNote(NotesModel value) async {
    final notesTable = await Hive.openBox<NotesModel>(dbName);
    final iD = await notesTable.add(value);
    value.id = iD;
    refreshUI();
  }

  Future<void> updateNote(NotesModel value, int id) async {
    final notesTable = await Hive.openBox<NotesModel>(dbName);
    await notesTable.put(id, value);
    refreshUI();
  }

  NotesModel getNoteById(int id) {
    return notesModelNotifier.value.firstWhere((note) => note.id == id);
  }

  Future<List<NotesModel>> getNotes() async {
    final notesTable = await Hive.openBox<NotesModel>(dbName);
    return notesTable.values.toList();
  }

  Future<void> deleteNote(int id) async {
    final notesTable = await Hive.openBox<NotesModel>(dbName);
    await notesTable.delete(id);
    refreshUI();
  }

  Future<void> refreshUI() async {
    final notesList = await getNotes();
    notesModelNotifier.value.clear();
    notesModelNotifier.value.addAll(notesList);
    notesModelNotifier.notifyListeners();
  }
}
