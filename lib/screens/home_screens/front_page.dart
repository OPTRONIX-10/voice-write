import 'package:flutter/material.dart';
import 'package:new_project/screens/home_screens/addNotes.dart';
import 'package:new_project/screens/home_screens/widgets/drawe.dart';
import 'package:new_project/services/auth/auth_services.dart';
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
  void dispose() {
    _notesService.close();
    super.dispose();
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
                                    return const Center(
                                        child: Text('waiting for notes'));
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddNotes(
              type: ActionType.addNote,
            ),
          ));
        },
        label: const Text('ADD'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
