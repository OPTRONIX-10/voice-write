// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:new_project/services/auth/auth_services.dart';
import 'package:new_project/services/crud/crud_model.dart';
import 'package:new_project/services/crud/notes_serveices.dart';

enum ActionType { addNote, saveNote }

class AddNotes extends StatefulWidget {
  AddNotes({
    Key? key,
    this.id,
    required this.type,
  }) : super(key: key);
  final int? id;
  final ActionType type;

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  late final TextEditingController _contentController;
  late final TextEditingController _titleController;
  final _scaffolKey = GlobalKey<ScaffoldState>();
  DatabaseNotes? _note;
  late final NotesService _notesService;

  @override
  void initState() {
    _notesService = NotesService();
    _titleController = TextEditingController();
    _contentController = TextEditingController();
    super.initState();
  }

  Future<DatabaseNotes> createNote() async {
    final existingNote = _note;
    if (existingNote != null) {
      return existingNote;
    }
    final currentUser = AuthServices.firebase().currentuser!.email!;
    final owner = await _notesService.getUser(email: currentUser);
    return await _notesService.createNote(owner);
  }

  Future<void> _addNote() async {
    final note = _note;
    final title = _titleController.text;
    final content = _contentController.text;
    if (note != null && title.isNotEmpty && content.isNotEmpty) {
      await _notesService.updateNote(
          note: note, title: title, content: content);
    }
    Navigator.of(_scaffolKey.currentContext!).pop();
  }

  Future<void> _updateNote() async {
    final note = _note;
    if (note == null) {
      return;
    }
    final title = _titleController.text;
    final content = _contentController.text;
    await _notesService.updateNote(note: note, title: title, content: content);
  }

  void _setupTextControllerListner() {
    _titleController.removeListener(() {
      _updateNote();
    });
    _contentController.removeListener(() {
      _updateNote();
    });

    _titleController.addListener(() {
      _updateNote();
    });
    _contentController.addListener(() {
      _updateNote();
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Widget get saveButton => TextButton.icon(
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
          color: Colors.white,
        ),
        label: const Text(
          'SAVE',
          style: TextStyle(color: Colors.white),
        ),
      );

  @override
  Widget build(BuildContext context) {
    //gettingNotes();
    return Scaffold(
        key: _scaffolKey,
        backgroundColor: const Color.fromARGB(255, 42, 39, 39),
        appBar: AppBar(
          title: Text(widget.type.name.toUpperCase()),
          actions: [saveButton],
        ),
        body: FutureBuilder(
            future: createNote(),
            builder: ((context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  _note = snapshot.data as DatabaseNotes?;
                  _setupTextControllerListner();
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _titleController,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: 'Title',
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 210, 208, 208),
                                fontSize: 18),
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
                          ),
                        )
                      ],
                    ),
                  );
                default:
                  return const Center(child: CircularProgressIndicator());
              }
            })));
  }
}



//   void gettingNotes() async {
//     if (type == ActionType.saveNote) {
//       if (id == null) {
//         Navigator.of(_scaffolKey.currentContext!).pop();
//       }

//       final note = NotesDbFunctions.instance.getNoteById(id!);
//       if (note == null) {
//         Navigator.of(_scaffolKey.currentContext!).pop();
//       }

//       _titleController.text = note!.title;
//       _contentController.text = note.text;
//     }
//   }

  