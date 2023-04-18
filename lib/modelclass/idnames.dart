import 'package:json_annotation/json_annotation.dart';

part 'idnames.g.dart';

@JsonSerializable()
class Idi {
  String stringValue;
  Idi({required this.stringValue});
  factory Idi.fromJson(Map<String, dynamic> json) => _$IdiFromJson(json);
  Map<String, dynamic> toJson() => _$IdiToJson(this);
}
