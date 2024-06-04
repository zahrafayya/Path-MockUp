import 'package:cloud_firestore/cloud_firestore.dart';

class CommentFields {
  static final List<String> values = [
    id, commentType, comment, createdTime
  ];

  static final String id = 'id';
  static final String commentType = 'commentType';
  static final String comment = 'comment';
  static final String createdTime = 'createdTime';
}

class Comment {
  final String? id;
  final String commentType;
  final String comment;
  final Timestamp createdTime;

  const Comment({
    this.id,
    required this.commentType,
    required this.comment,
    required this.createdTime
  });

  static Comment fromJson(Object? json) {
    if (json == null) {
      throw ArgumentError.notNull('json');
    }

    final Map<String, dynamic>? jsonMap = json as Map<String, dynamic>?;

    if (jsonMap == null) {
      throw ArgumentError.value(json, 'json', 'Invalid JSON format');
    }

    return Comment(
      id: jsonMap[CommentFields.id] as String? ?? '',
      commentType: jsonMap[CommentFields.commentType] as String? ?? '',
      comment: jsonMap[CommentFields.comment] as String? ?? '',
      createdTime: jsonMap[CommentFields.createdTime] as Timestamp,
    );
  }

  Map<String, Object?> toJson() => {
    CommentFields.id: id,
    CommentFields.commentType: commentType,
    CommentFields.comment: comment,
    CommentFields.createdTime: createdTime,
  };
}