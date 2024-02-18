// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:new_project/services/auth/auth_services.dart';
import 'package:new_project/services/cloud/firebase_cloud_storage.dart';

enum ActionType { addNote, saveNote }

class AddNotes extends StatefulWidget {
  AddNotes({
    Key? key,
    this.id,
    required this.type,
  }) : super(key: key);
  final String? id;
  final ActionType type;

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  late final TextEditingController _contentController;
  late final TextEditingController _titleController;
  final _scaffolKey = GlobalKey<ScaffoldState>();
  late final FirebaseCloudStorage _notesService;

  @override
  void initState() {
    _notesService = FirebaseCloudStorage();
    _titleController = TextEditingController();
    _contentController = TextEditingController();
    super.initState();
  }

  Future _addNote() async {
    final currentUser = AuthServices.firebase().currentuser!;
    final userId = currentUser.id;

    final title = _titleController.text;
    final content = _contentController.text;

    await _notesService.createNewNote(
        ownerUserId: userId, title: title, content: content);

    Navigator.of(_scaffolKey.currentContext!).pop();
  }

  gettingNote() async {
    if (widget.type == ActionType.saveNote) {
      if (widget.id == null) {
        Navigator.of(context).pop();
      }

      final note =
          await _notesService.getNotesById(documentId: widget.id.toString());

      _titleController.text = note.title;
      _contentController.text = note.content;
    }
  }

  Future<void> _updateNote() async {
    final title = _titleController.text;
    final content = _contentController.text;
    await _notesService.updateNote(
        documentId: widget.id.toString(), title: title, content: content);
    Navigator.of(_scaffolKey.currentContext!).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Widget get saveButton => IconButton(
        onPressed: () async {
          switch (widget.type) {
            case ActionType.addNote:
              _addNote();
              break;
            case ActionType.saveNote:
              _updateNote();
              break;
          }
        },
        icon: const Icon(
          Icons.save,
          color: Colors.teal,
        ),
      );

  @override
  Widget build(BuildContext context) {
    gettingNote();
    return Scaffold(
        key: _scaffolKey,
        backgroundColor: const Color.fromARGB(255, 42, 39, 39),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 82, 81, 81),
          title: Text(widget.type.name.toUpperCase(),
              style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 2, 158, 122))),
          actions: [saveButton],
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
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
                          color: Color.fromARGB(255, 210, 208, 208),
                          fontSize: 18),
                      filled: true,
                      fillColor: Color.fromARGB(255, 82, 81, 81),
                      counterText: ''),
                )
              ],
            ),
          ),
        ));
  }
}
