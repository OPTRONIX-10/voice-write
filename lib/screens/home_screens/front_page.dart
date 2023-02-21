import 'package:flutter/material.dart';
import 'package:new_project/screens/home_screens/widgets/drawe.dart';

class MainNotes extends StatelessWidget {
  MainNotes({super.key});

  final _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
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
            )
          ],
        ),
      ),
    );
  }
}
