import 'package:flutter/material.dart';
import 'package:new_project/screens/home_screens/addNotes.dart';
import 'package:new_project/screens/home_screens/widgets/notes_view_widget.dart';
import 'package:new_project/services/auth/auth_services.dart';
import 'package:new_project/services/cloud/cloud_note.dart';
import 'package:new_project/services/cloud/firebase_cloud_storage.dart';

class MainNotes extends StatefulWidget {
  MainNotes({super.key});

  @override
  State<MainNotes> createState() => _MainNotesState();
}

class _MainNotesState extends State<MainNotes> {
  late FirebaseCloudStorage _notesService;
  String get userId => AuthServices.firebase().currentuser!.id;

  @override
  void initState() {
    _notesService = FirebaseCloudStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 42, 39, 39),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
            child: StreamBuilder(
                stream: _notesService.getAllNotes(owneruserId: userId),
                builder: ((context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.active:
                      if (snapshot.hasData) {
                        final allnotes = snapshot.data as Iterable<CloudNote>;
                        return GridView.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          padding: const EdgeInsets.all(20),
                          children: List.generate(allnotes.length, (index) {
                            final notesList = allnotes.elementAt(index);
                            return NotesView(
                                id: notesList.documentId,
                                title: notesList.title,
                                content: notesList.content);
                          }),
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    default:
                      return Center(child: CircularProgressIndicator());
                  }
                }))),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddNotes(
              type: ActionType.addNote,
            ),
          ));
        },
        child: const Icon(Icons.note_alt_outlined),
      ),
    );
  }
}
