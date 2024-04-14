class NotesModel {
  final String title;
  final String description;
  final String timeStamp;
  NotesModel({
    required this.title,
    required this.description,
    required this.timeStamp,
  });

  NotesModel copyWith({
    String? title,
    String? description,
    String? timeStamp,
  }) {
    return NotesModel(
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
      title: map['title'] as String,
      description: map['description'] as String,
      timeStamp: map['timeStamp'] as String,
    );
  }
}
