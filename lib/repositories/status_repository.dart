import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_mock_up/model/profile.dart';
import 'package:path_mock_up/model/status.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path_mock_up/repositories/profile.repository.dart';

class StatusRepository {
  final db = FirebaseFirestore.instance;

  CollectionReference _statusesCollection = FirebaseFirestore.instance.collection('statuses');

  Future<List<Status>> getAllStatuses() async {
    try {
      // Fetch all statuses
      QuerySnapshot statusSnapshot = await FirebaseFirestore.instance.collection('statuses').get();

      List<Status> statuses = statusSnapshot.docs.map((doc) {
        return Status.fromJson(doc.data() as Map<String, dynamic>)..id = doc.id;
      }).toList();

      // Fetch profiles for each status
      for (Status status in statuses) {
        DocumentSnapshot profileSnapshot = await FirebaseFirestore.instance
            .collection('profiles')
            .doc(status.profileId)
            .get();

        if (profileSnapshot.exists) {
          status.profile = Profile.fromJson(profileSnapshot.data() as Map<String, dynamic>);
        }
      }

      // Optionally sort statuses by createdTime
      statuses.sort((a, b) => b.createdTime.compareTo(a.createdTime));

      return statuses;
    } catch (e) {
      print('Error fetching statuses with profiles: $e');
      return [];
    }
  }

  Future<Status?> getStatusById(String statusId) async {
    try {
      final DocumentSnapshot snapshot = await _statusesCollection.doc(statusId).get();

      if (snapshot.exists) {
        final Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        data['id'] = snapshot.id;
        return Status.fromJson(data);
      } else {
        return null;
      }
    } catch (e) {
      print('Error getting status by ID: $e');
      return null;
    }
  }

  Future<void> createStatus(Status status) async {
    try {
      Map<String, dynamic> statusData = status.toJson();

      await _statusesCollection.add(statusData);

      print('Status created successfully');
    } catch (e) {
      print('Error creating status: $e');
      // You can choose to throw the error to be handled by the caller if needed
      throw e;
    }
  }

  Future<void> updateStatus(String statusId, Status status) async {
    try {
      Map<String, dynamic> updatedData = status.toJson();

      await _statusesCollection.doc(statusId).update(updatedData);
      print('Status updated successfully');
    } catch (e) {
      print('Error updating status: $e');
      throw e;
    }
  }

  Future<void> deleteStatus(String statusId) async {
    try {
      await _statusesCollection.doc(statusId).delete();
    } catch (e) {
      print('Error deleting status: $e');
    }
  }
}