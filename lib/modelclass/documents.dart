import 'package:json_annotation/json_annotation.dart';
import 'package:juiesapk/modelclass/field.dart';

part 'documents.g.dart';

@JsonSerializable()
class Document {
  Field fields;
  Document({required this.fields});
  factory Document.fromJson(Map<String, dynamic> json) =>
      _$DocumentFromJson(json);
  Map<String, dynamic> toJson() => _$DocumentToJson(this);
}
