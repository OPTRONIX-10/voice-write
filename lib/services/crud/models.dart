import 'package:hive_flutter/hive_flutter.dart';
part 'models.g.dart';

@HiveType(typeId: 1)
class NotesModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  int? userId;

  @HiveField(2)
  final String title;

  @HiveField(3)
  final String text;

  NotesModel({this.userId, required this.title, required this.text, this.id});
}

@HiveType(typeId: 2)
class UserModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  final String email;

  UserModel({required this.email, this.id});
}
