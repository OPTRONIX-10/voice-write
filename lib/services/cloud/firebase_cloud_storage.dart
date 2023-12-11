
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_project/services/cloud/cloud_note.dart';
import 'package:new_project/services/cloud/cloud_storage_constants.dart';
import 'package:new_project/services/cloud/cloud_storage_exceptions.dart';

class FirebaseCloudStorage {
  FirebaseCloudStorage._instacne();
  static FirebaseCloudStorage _shared = FirebaseCloudStorage._instacne();
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
    return notes.snapshots().map((event) => event.docs
        .map((doc) => CloudNote.fromSnapshot(doc))
        .where((note) => note.ownerUserId == owneruserId));
  }

  Future<Iterable<CloudNote>> getNotes({required String ownerUserId}) async {
    try {
      return await notes
          .where(ownerUserIdFieldName, isEqualTo: ownerUserId)
          .get()
          .then(
              (value) => value.docs.map((doc) => CloudNote.fromSnapshot(doc)));
    } catch (e) {
      throw CouldNotGetAllNotesException();
    }
  }

  Future<CloudNote> createNewNote({required String ownerUserId}) async {
    final document = await notes.add({
      ownerUserIdFieldName: ownerUserId,
      titleFieldName: '',
      contentFieldName: '',
    });

    final fetchedNote = await document.get();

    return CloudNote(
        documentId: fetchedNote.id,
        ownerUserId: ownerUserId,
        title: '',
        content: '');
  }
}
