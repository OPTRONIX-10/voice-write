import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
      onTap: () {},
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
                    onPressed: () {},
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
