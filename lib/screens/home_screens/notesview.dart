// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:new_project/services/crud/dbFunctions.dart';

import 'addNotes.dart';

class NotesView extends StatelessWidget {
  NotesView({
    Key? key,
    required this.id,
    required this.title,
    required this.content,
  }) : super(key: key);
  final int id;
  final String title;
  final String content;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddNotes(
            type: ActionType.saveNote,
            id: id,
          ),
        ));
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.teal),
            borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      NotesDbFunctions.instance.deleteNote(id);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ))
              ],
            ),
            Text(
              content,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
                overflow: TextOverflow.ellipsis,
              ),
              maxLines: 5,
            )
          ],
        ),
      ),
    );
  }
}
