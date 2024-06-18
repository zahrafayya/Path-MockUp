class Comment {
  final String id;
  final String text;
  final DateTime createdTime;
  final String userId;
  final String postId;

  Comment({
    required this.id,
    required this.text,
    required this.createdTime,
    required this.userId,
    required this.postId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'createdTime': createdTime.toIso8601String(),
      'userId': userId,
      'postId': postId,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      id: map['id'],
      text: map['text'],
      createdTime: DateTime.parse(map['createdTime']),
      userId: map['userId'],
      postId: map['postId'],
    );
  }
}