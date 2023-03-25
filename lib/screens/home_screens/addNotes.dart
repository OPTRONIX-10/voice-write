// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:new_project/services/crud/dbFunctions.dart';
import 'package:new_project/services/crud/models.dart';

enum ActionType { addNote, saveNote }

class AddNotes extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final _scaffolKey = GlobalKey<ScaffoldState>();
  AddNotes({
    Key? key,
    this.id,
    required this.type,
  }) : super(key: key);
  final int? id;
  final ActionType type;

  Widget get saveButton => TextButton.icon(
        onPressed: () async {
          switch (type) {
            case ActionType.addNote:
              addNote();
              break;
            case ActionType.saveNote:
              saveNote();
              break;
          }
        },
        icon: const Icon(
          Icons.save,
          color: Colors.white,
        ),
        label: const Text(
          'SAVE',
          style: TextStyle(color: Colors.white),
        ),
      );

  @override
  Widget build(BuildContext context) {
    gettingNotes();
    return Scaffold(
      key: _scaffolKey,
      backgroundColor: const Color.fromARGB(255, 42, 39, 39),
      appBar: AppBar(
        title: Text(type.name.toUpperCase()),
        actions: [saveButton],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Title',
                hintStyle: TextStyle(
                    color: Color.fromARGB(255, 210, 208, 208), fontSize: 18),
                filled: true,
                fillColor: Color.fromARGB(255, 82, 81, 81),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _contentController,
              maxLength: 100,
              maxLines: 4,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Content',
                hintStyle: TextStyle(
                    color: Color.fromARGB(255, 210, 208, 208), fontSize: 18),
                filled: true,
                fillColor: Color.fromARGB(255, 82, 81, 81),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> addNote() async {
    final title = _titleController.text;
    final content = _contentController.text;
    final notesValue = NotesModel(
      title: title,
      text: content,
    );
    await NotesDbFunctions.instance.createNote(notesValue);
    Navigator.of(_scaffolKey.currentContext!).pop();
  }

  void gettingNotes() async {
    if (type == ActionType.saveNote) {
      if (id == null) {
        Navigator.of(_scaffolKey.currentContext!).pop();
      }

      final note = NotesDbFunctions.instance.getNoteById(id!);

      _titleController.text = note.title;
      _contentController.text = note.text;
    }
  }

  Future<void> saveNote() async {
    final title = _titleController.text;
    final content = _contentController.text;

    final notesValue = NotesModel(
      id: id,
      title: title,
      text: content,
    );
    if (notesValue.id != null) {
      await NotesDbFunctions.instance.updateNote(notesValue, id!);
      Navigator.of(_scaffolKey.currentContext!).pop();
    }
  }
}
