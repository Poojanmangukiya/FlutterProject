// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'field.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Field _$FieldFromJson(Map<String, dynamic> json) => Field(
      title: Title.fromJson(json['title'] as Map<String, dynamic>),
      notes: Note.fromJson(json['notes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FieldToJson(Field instance) => <String, dynamic>{
      'title': instance.title,
      'notes': instance.notes,
    };
