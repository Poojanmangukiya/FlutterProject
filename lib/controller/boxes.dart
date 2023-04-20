import 'package:hive/hive.dart';
import 'package:juiesapk/controller/hivestore.dart';

class Boxes {
  static Box<NotesModel> getData() => Hive.box('notes');
}
