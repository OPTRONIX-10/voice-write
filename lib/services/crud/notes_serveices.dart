import 'package:new_project/services/crud/crud_constants.dart';
import 'package:new_project/services/crud/crud_exceptions.dart';
import 'package:new_project/services/crud/crud_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';



class NotesService {
  Database? _db;

  Database _getDatabase() {
    final db = _db;
    if (db == null) {
      throw DatabaseIsNotOpenException();
    } else {
      return db;
    }
  }

  Future<void> openDb() async {
    if (_db != null) {
      throw DatabaseAlreadyOpenException();
    }
    try {
      final docsPath = await getApplicationDocumentsDirectory();
      final dbPath = join(docsPath.path, dbName);
      final db = await openDatabase(dbPath);
      _db = db;
      await db.execute(createUserTable);
      await db.execute(createNotesTable);
    } on MissingPlatformDirectoryException {
      throw UnableTogetDocumentsDirectory();
    }
  }

  Future<void> close() async {
    final db = _db;
    if (db == null) {
      throw DatabaseIsNotOpenException();
    } else {
      await db.close();
      _db = null;
    }
  }

  Future<DatabaseUser> createUser({required String email}) async {
    final db = _getDatabase();
    final result = await db.query(userTable,
        limit: 1, where: '$emailColumn=?', whereArgs: [email.toLowerCase()]);

    if (result.isNotEmpty) {
      throw UserAlreadyExistsException();
    }

    final userId =
        await db.insert(userTable, {emailColumn: email.toLowerCase()});

    return DatabaseUser(id: userId, email: email);
  }

  Future<void> deleteUser({required String email}) async {
    final db = _getDatabase();
    final deleteCount = await db.delete(userTable,
        where: '$emailColumn=?', whereArgs: [email.toLowerCase()]);
    if (deleteCount != 1) {
      throw CouldNotDeleteUserException();
    }
  }

  Future<DatabaseUser> getUser({required String email}) async {
    final db = _getDatabase();
    final result = await db.query(userTable,
        limit: 1, where: '$emailColumn=?', whereArgs: [email.toLowerCase()]);
    if (result.isEmpty) {
      throw CouldNotFindUserException();
    } else {
      return DatabaseUser.fromRow(result.first);
    }
  }

  Future<DatabaseNotes> createNote(DatabaseUser owner) async {
    final db = _getDatabase();

    // make sure the user exists with correct id
    final dbUser = await getUser(email: owner.email);

    if (dbUser != owner) {
      throw CouldNotFindUserException();
    }

    final noteId = await db.insert(noteTable,
        {userIdColumn: owner.id, titleColumn: '', contentColumn: ''});

    final note =
        DatabaseNotes(id: noteId, userId: owner.id, title: '', content: '');

    return note;
  }

  Future<void> deleteNote({required int id}) async {
    final db = _getDatabase();

    final deleteCount =
        await db.delete(noteTable, where: '$idColumn=?', whereArgs: [id]);

    if (deleteCount != 1) {
      throw CouldNotDeleteNoteException();
    }
  }

  Future<int> deleteAllNote() async {
    final db = _getDatabase();
    return await db.delete(noteTable);
  }

  Future<DatabaseNotes> getNotes({required int id}) async {
    final db = _getDatabase();

    final result = await db
        .query(noteTable, limit: 1, where: '$idColumn=?', whereArgs: [id]);

    if (result.isEmpty) {
      throw CouldNotFindNoteException();
    } else {
      return DatabaseNotes.fromRow(result.first);
    }
  }

  Future<Iterable<DatabaseNotes>> getAllNotes() async {
    final db = _getDatabase();
    final notes = await db.query(noteTable);
    return notes.map((noteRow) => DatabaseNotes.fromRow(noteRow));
  }

  Future<DatabaseNotes> updateNote(
      {required DatabaseNotes note,
      required String title,
      required String content}) async {
    final db = _getDatabase();

    await getNotes(id: note.id);

    final updateCount = await db.update(
        noteTable,
        where: '$idColumn=?',
        whereArgs: [note.id],
        {titleColumn: title, contentColumn: content});

    if (updateCount != 1) {
      throw CouldNotUpdateNoteException();
    } else {
      return await getNotes(id: note.id);
    }
  }
}


