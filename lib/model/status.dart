import 'package:cloud_firestore/cloud_firestore.dart';

class StatusFields {
  static final List<String> values = [
    id, statusType, status, createdTime
  ];

  static final String id = 'id';
  static final String statusType = 'statusType';
  static final String status = 'status';
  static final String createdTime = 'createdTime';
}

class Status {
  final String? id;
  final String statusType;
  final String status;
  final Timestamp createdTime;

  const Status({
    this.id,
    required this.statusType,
    required this.status,
    required this.createdTime
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
      id: jsonMap[StatusFields.id] as String? ?? '',
      statusType: jsonMap[StatusFields.statusType] as String? ?? '',
      status: jsonMap[StatusFields.status] as String? ?? '',
      createdTime: jsonMap[StatusFields.createdTime] as Timestamp,
    );
  }

  Map<String, Object?> toJson() => {
    StatusFields.id: id,
    StatusFields.statusType: statusType,
    StatusFields.status: status,
    StatusFields.createdTime: createdTime,
  };
}