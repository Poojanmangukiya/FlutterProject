// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'documentinfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentInfo _$DocumentInfoFromJson(Map<String, dynamic> json) => DocumentInfo(
      documents: (json['documents'] as List<dynamic>?)
          ?.map((e) => Document.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DocumentInfoToJson(DocumentInfo instance) =>
    <String, dynamic>{
      'documents': instance.documents,
    };
