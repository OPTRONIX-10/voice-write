import 'package:flutter/material.dart';
import 'package:new_project/screens/home_screens/addNotes.dart';
import 'package:new_project/screens/home_screens/widgets/drawe.dart';
import 'package:new_project/screens/home_screens/widgets/notes_view_widget.dart';
import 'package:new_project/services/auth/auth_services.dart';
import 'package:new_project/services/crud/crud_model.dart';
import 'package:new_project/services/crud/notes_serveices.dart';

class MainNotes extends StatefulWidget {
  MainNotes({super.key});

  @override
  State<MainNotes> createState() => _MainNotesState();
}

class _MainNotesState extends State<MainNotes> {
  late NotesService _notesService;
  String get userEmail => AuthServices.firebase().currentuser!.email!;

  @override
  void initState() {
    _notesService = NotesService();
    _notesService.openDb();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 42, 39, 39),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
            child: //ValueListenableBuilder(
                //     valueListenable: notesModelNotifier,
                //     builder: (BuildContext context, List<NotesModel> newList,
                //         Widget? _) {
                //       return GridView.count(
                //         crossAxisCount: 2,
                //         mainAxisSpacing: 10,
                //         crossAxisSpacing: 10,
                //         padding: const EdgeInsets.all(20),
                //         children: List.generate(newList.length, (index) {
                //           final notesList = newList[index];
                //           try {} catch (_) {
                //             return const Text(
                //               'NOTES',
                //               style: TextStyle(color: Colors.white),
                //             );
                //           }
                //         }),
                //       );
                //     })
                FutureBuilder(
                    future: _notesService.getOrCreateUser(email: userEmail),
                    builder: ((context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.done:
                          return StreamBuilder(
                              stream: _notesService.allnotes,
                              builder: ((context, snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.waiting:
                                  case ConnectionState.active:
                                    if (snapshot.hasData) {
                                      final allnotes =
                                          snapshot.data as List<DatabaseNotes>;
                                      return GridView.count(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 10,
                                        padding: const EdgeInsets.all(20),
                                        children: List.generate(allnotes.length,
                                            (index) {
                                          final notesList = allnotes[index];
                                          return NotesView(
                                              id: notesList.id,
                                              title: notesList.title,
                                              content: notesList.content);
                                        }),
                                      );
                                    } else {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    }
                                  default:
                                    return Center(
                                        child: CircularProgressIndicator());
                                }
                              }));
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
