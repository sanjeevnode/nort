class Note {
  final int? id;
  final int userId;
  final String title;
  final String content;
  final String? createdAt;
  final String? updatedAt;
  final String? salt;

  Note({
    required this.userId,
    required this.title,
    required this.content,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.salt,
  });

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'] as int?,
      userId: map['userId'] as int,
      title: map['title'] as String,
      content: map['content'] as String,
      salt: map['salt'] as String?,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'content': content,
      'salt': salt,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  Note copyWith({
    int? id,
    int? userId,
    String? title,
    String? content,
    String? salt,
    String? createdAt,
    String? updatedAt,
  }) {
    return Note(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      content: content ?? this.content,
      salt: salt ?? this.salt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'Note{\nid: $id, \nuserId: $userId, \ntitle: $title, \ncontent: $content, \nsalt: $salt, \ncreatedAt: $createdAt, \nupdatedAt: $updatedAt}';
  }
}
