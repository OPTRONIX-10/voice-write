import 'package:flutter/material.dart';
import 'package:new_project/screens/home_screens/addNotes.dart';
import 'package:new_project/screens/home_screens/notesview.dart';
import 'package:new_project/screens/home_screens/widgets/drawe.dart';
import 'package:new_project/services/crud/dbFunctions.dart';

import '../../services/crud/models.dart';

class MainNotes extends StatelessWidget {
  MainNotes({super.key});

  final _scaffoldkey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    NotesDbFunctions.instance.refreshUI();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 42, 39, 39),
      key: _scaffoldkey,
      drawer: const Drawerview(),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(17, 15, 17, 0),
              child: SizedBox(
                height: 55,
                child: TextFormField(
                  controller: _searchcontroller,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      hintText: 'Search your notes',
                      hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 210, 208, 208),
                          fontSize: 18),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 82, 81, 81),
                      prefixIcon: IconButton(
                          onPressed: () {
                            _scaffoldkey.currentState?.openDrawer();
                          },
                          icon: const Icon(
                            Icons.menu,
                            color: Color.fromARGB(255, 2, 158, 122),
                          )),
                      suffixIcon: IconButton(
                          onPressed: () {}, icon: const CircleAvatar())),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
                child: ValueListenableBuilder(
                    valueListenable: notesModelNotifier,
                    builder: (BuildContext context, List<NotesModel> newList,
                        Widget? _) {
                      return GridView.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        padding: const EdgeInsets.all(20),
                        children: List.generate(newList.length, (index) {
                          final notesList = newList[index];
                          try {
                          
                          } catch (_) {
                            return const Text(
                              'NOTES',
                              style: TextStyle(color: Colors.white),
                            );
                          }
                        }),
                      );
                    }))
          ],
        ),
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
