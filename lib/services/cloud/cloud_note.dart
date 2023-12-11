import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_project/services/cloud/cloud_storage_constants.dart';

class CloudNote {
  final String documentId;
  final String ownerUserId;
  final String title;
  final String content;

  CloudNote(
      {required this.documentId,
      required this.ownerUserId,
      required this.title,
      required this.content});

  CloudNote.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        ownerUserId = snapshot.get(ownerUserIdFieldName),
        title = snapshot.get(titleFieldName) as String,
        content = snapshot.get(contentFieldName) as String;
}
