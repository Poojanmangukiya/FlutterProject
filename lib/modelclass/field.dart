import 'package:json_annotation/json_annotation.dart';
import 'package:juiesapk/modelclass/idnames.dart';
import 'package:juiesapk/modelclass/notename.dart';
import 'package:juiesapk/modelclass/titilename.dart';

part 'field.g.dart';

@JsonSerializable()
class Field {
  Title title;
  Note notes;
  Idi? id;
  Field({required this.title, required this.notes, this.id});
  factory Field.fromJson(Map<String, dynamic> json) => _$FieldFromJson(json);
  Map<String, dynamic> toJson() => _$FieldToJson(this);
}
