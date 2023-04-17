import 'package:json_annotation/json_annotation.dart';
import 'package:juiesapk/modelclass/notename.dart';
import 'package:juiesapk/modelclass/titilename.dart';

part 'field.g.dart';

@JsonSerializable()
class Field {
  Title title;
  Note notes;
  Field({required this.title, required this.notes});
  factory Field.fromJson(Map<String, dynamic> json) => _$FieldFromJson(json);
  Map<String, dynamic> toJson() => _$FieldToJson(this);
}
