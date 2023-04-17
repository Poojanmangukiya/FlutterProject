import 'package:json_annotation/json_annotation.dart';
import 'package:juiesapk/modelclass/documents.dart';

part 'documentinfo.g.dart';

@JsonSerializable()
class DocumentInfo {
  List<Document>? documents;

  DocumentInfo({this.documents});

  DocumentInfo.fromJson(Map<String, dynamic> json) {
    if (json['documents'] != null) {
      documents = <Document>[];
      json['documents'].forEach((v) {
        documents!.add(new Document.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.documents != null) {
      data['documents'] = this.documents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
