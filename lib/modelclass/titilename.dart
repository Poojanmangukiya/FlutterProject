import 'package:json_annotation/json_annotation.dart';

part 'titilename.g.dart';

@JsonSerializable()
class Title {
  String stringValue;
  Title({required this.stringValue});
  factory Title.fromJson(Map<String, dynamic> json) => _$TitleFromJson(json);
  Map<String, dynamic> toJson() => _$TitleToJson(this);
}
