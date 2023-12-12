import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:new_project/screens/home_screens/addNotes.dart';
import 'package:new_project/services/cloud/firebase_cloud_storage.dart';

class NotesView extends StatelessWidget {
  NotesView({
    Key? key,
    required this.id,
    required this.title,
    required this.content,
  }) : super(key: key);
  final String id;
  final String title;
  final String content;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddNotes(
            id: id,
            type: ActionType.saveNote,
          ),
        ));
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.teal),
            borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.all(10),
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
              ],
            ),
            SizedBox(height: 10),
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
