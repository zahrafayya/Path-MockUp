import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path_mock_up/model/profile.dart';

class StatusFields {
  static final List<String> values = [
    id, profileId, statusType, status, createdTime, profile
  ];

  static final String id = 'id';
  static final String profileId = 'profileId';
  static final String statusType = 'statusType';
  static final String status = 'status';
  static final String createdTime = 'createdTime';
  static final String profile = 'profile';
}

class Status {
  String? id;
  final String profileId;
  final String statusType;
  final String status;
  final Timestamp createdTime;
  Profile? profile;

  Status({
    this.id,
    required this.profileId,
    required this.statusType,
    required this.status,
    required this.createdTime,
    this.profile,
  });

  static Status fromJson(Object? json) {
    if (json == null) {
      throw ArgumentError.notNull('json');
    }

    final Map<String, dynamic>? jsonMap = json as Map<String, dynamic>?;

    if (jsonMap == null) {
      throw ArgumentError.value(json, 'json', 'Invalid JSON format');
    }

    return Status(
      profileId: jsonMap[StatusFields.profileId] as String? ?? '',
      statusType: jsonMap[StatusFields.statusType] as String? ?? '',
      status: jsonMap[StatusFields.status] as String? ?? '',
      createdTime: jsonMap[StatusFields.createdTime] as Timestamp,
    );
  }

  Map<String, Object?> toJson() => {
    StatusFields.profileId: profileId,
    StatusFields.statusType: statusType,
    StatusFields.status: status,
    StatusFields.createdTime: createdTime,
  };
}