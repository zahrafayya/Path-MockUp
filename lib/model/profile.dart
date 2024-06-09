import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileFields {
  static final List<String> values = [
    id, userId, username
  ];

  static final String id = 'id';
  static final String userId = 'userId';
  static final String username = 'username';
}

class Profile {
  final String? id;
  final String userId;
  final String username;

  const Profile({
    this.id,
    required this.userId,
    required this.username
  });

  static Profile fromJson(Object? json) {
    if (json == null) {
      throw ArgumentError.notNull('json');
    }

    final Map<String, dynamic>? jsonMap = json as Map<String, dynamic>?;

    if (jsonMap == null) {
      throw ArgumentError.value(json, 'json', 'Invalid JSON format');
    }

    return Profile(
      id: jsonMap[ProfileFields.id] as String? ?? '',
      userId: jsonMap[ProfileFields.userId] as String? ?? '',
      username: jsonMap[ProfileFields.username] as String? ?? '',
    );
  }

  Map<String, Object?> toJson() => {
    ProfileFields.id: id,
    ProfileFields.userId: userId,
    ProfileFields.username: username,
  };
}