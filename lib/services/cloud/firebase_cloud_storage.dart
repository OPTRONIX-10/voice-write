import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_project/services/cloud/cloud_note.dart';
import 'package:new_project/services/cloud/cloud_storage_constants.dart';
import 'package:new_project/services/cloud/cloud_storage_exceptions.dart';

class FirebaseCloudStorage {
  FirebaseCloudStorage._instance();
  static FirebaseCloudStorage _shared = FirebaseCloudStorage._instance();
  factory FirebaseCloudStorage() => _shared;

  final notes = FirebaseFirestore.instance.collection('notes');

  Future<void> deleteNote({required String documentId}) async {
    try {
      await notes.doc(documentId).delete();
    } catch (e) {
      throw CouldNotDeleteNoteException();
    }
  }

  Future<void> updateNote({
    required String documentId,
    required String title,
    required String content,
  }) async {
    try {
      await notes.doc(documentId).update({
        titleFieldName: title,
        contentFieldName: content,
      });
    } catch (e) {
      throw CouldNotUpdateNoteException();
    }
  }

  Stream<Iterable<CloudNote>> getAllNotes({required String owneruserId}) {
    return notes
        .where(ownerUserIdFieldName, isEqualTo: owneruserId)
        .snapshots()
        .map((event) => event.docs.map((doc) => CloudNote.fromSnapshot(doc)));
  }

  Future<CloudNote> getNotesById({required String documentId}) async {
    try {
      final document = await notes.doc(documentId).get();
      return CloudNote(
          documentId: document.id,
          ownerUserId: document.get(ownerUserIdFieldName),
          title: document.get(titleFieldName),
          content: document.get(contentFieldName));
    } catch (e) {
      throw CouldNotGetAllNotesException();
    }
  }

  Future<CloudNote> createNewNote({
    required String ownerUserId,
    required String title,
    required String content,
  }) async {
    final document = await notes.add({
      ownerUserIdFieldName: ownerUserId,
      titleFieldName: title,
      contentFieldName: content,
    });

    final fetchedNote = await document.get();

    return CloudNote(
        documentId: fetchedNote.id,
        ownerUserId: ownerUserId,
        title: fetchedNote.get(titleFieldName) ?? '',
        content: fetchedNote.get(contentFieldName) ?? '');
  }
}
