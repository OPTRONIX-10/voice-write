import 'package:hive_flutter/hive_flutter.dart';
part 'models.g.dart';

@HiveType(typeId: 1)
class NotesModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String text;

  NotesModel({required this.title, required this.text, this.id});
}
