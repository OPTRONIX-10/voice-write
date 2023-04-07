import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'models.dart';

const String dbName = 'Notes Database';
 
ValueNotifier<List<NotesModel>> notesModelNotifier = ValueNotifier([]);
List<UserModel> UserList = [];

//Note Table

class NotesDbFunctions {
  NotesDbFunctions.internals();
  static NotesDbFunctions instance = NotesDbFunctions.internals();
  factory NotesDbFunctions() {
    return instance;
  }

  Future<void> createNote(NotesModel value) async {
    //final user = UserDbFunctions.instance.getUserbyEmail(owner.email);
    final notesTable = await Hive.openBox<NotesModel>(dbName);
    final iD = await notesTable.add(value);
    value.id = iD;
    //value.userId = user.id;
    refreshUI();
  }

  Future<void> updateNote(NotesModel value, int id) async {
    final notesTable = await Hive.openBox<NotesModel>(dbName);
    await notesTable.put(id, value);
    refreshUI();
  }

  NotesModel? getNoteById(int id) {
    try {
      return notesModelNotifier.value.firstWhere((note) => note.id == id);
    } catch (_) {
      return null;
    }
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
    notesModelNotifier.value.addAll(notesList.reversed);
    notesModelNotifier.notifyListeners();
  }
}

// User Table

class UserDbFunctions {
  UserDbFunctions.internal();
  static UserDbFunctions instance = UserDbFunctions.internal();

  factory UserDbFunctions() {
    return instance;
  }

  Future<void> createUser(UserModel value) async {
    final userTable = await Hive.openBox<UserModel>(dbName);
    final id = await userTable.add(value);
    value.id = id;
  }

  Future<void> deleteUser(int id) async {
    final userTable = await Hive.openBox<UserModel>(dbName);
    userTable.delete(id);
  }

  Future<void> getUser() async {
    final userTable = await Hive.openBox<UserModel>(dbName);
    final userValues = userTable.values.toList();
    UserList.clear();
    UserList.addAll(userValues);
  }

  UserModel? getUserbyEmail(String email) {
    try {
      return UserList.firstWhere((user) => user.email == email);
    } catch (_) {
      return null;
    }
  }
}
