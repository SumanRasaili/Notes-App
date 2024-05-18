import 'package:cloud_firestore/cloud_firestore.dart';

class NotesModel {
  final String? id;
  final String? title;
  final String? description;
  final DateTime? date;
  final DateTime? createdDate;
  NotesModel(
      {required this.title,
      required this.id,
      required this.description,
      required this.date,
      required this.createdDate});

  NotesModel copyWith(
      {String? title,
      String? id,
      String? description,
      DateTime? date,
      DateTime? createdDate}) {
    return NotesModel(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        date: date ?? this.date,
        createdDate: createdDate ?? this.createdDate);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      'title': title,
      'description': description,
      'date': date,
      "created_date": createdDate
    };
  }

  factory NotesModel.fromJson(Map<String, dynamic> map) {
    return NotesModel(
        id: map["id"] ?? "",
        title: map['title'] ?? "",
        description: map['description'] ?? "",
        date: (map["date"] as Timestamp).toDate(),
        createdDate: (map["created_date"] as Timestamp).toDate());
  }
}
