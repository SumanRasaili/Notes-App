class NotesModel {
  final String? id;
  final String? title;
  final String? description;
  final String? timeStamp;
  NotesModel({
    required this.title,
    required this.id,
    required this.description,
    required this.timeStamp,
  });

  NotesModel copyWith({
    String? title,
    String? id,
    String? description,
    String? timeStamp,
  }) {
    return NotesModel(
      id: id??this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      timeStamp: timeStamp ?? this.timeStamp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'timeStamp': timeStamp,
    };
  }

  factory NotesModel.fromJson(Map<String, dynamic> map) {
    return NotesModel(
      id: map["id"]??"",
      title: map['title'] ?? "",
      description: map['description'] ?? "",
      timeStamp: map['timeStamp'] ?? "",
    );
  }
}
