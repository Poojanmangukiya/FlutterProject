import 'package:json_annotation/json_annotation.dart';

part 'notename.g.dart';

@JsonSerializable()
class Note {
  String stringValue;
  Note({required this.stringValue});
  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);
  Map<String, dynamic> toJson() => _$NoteToJson(this);
}
