import 'package:hive/hive.dart';
part 'hivestore.g.dart';

@HiveType(typeId: 0)
class NotesModel extends HiveObject {
  NotesModel({required this.titles, required this.note});

  @HiveField(0)
  String titles;
  @HiveField(1)
  String note;
}
