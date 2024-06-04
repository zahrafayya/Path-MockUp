import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_mock_up/model/status.dart';

class StatusRepository {
  final db = FirebaseFirestore.instance;

  CollectionReference _statusesCollection = FirebaseFirestore.instance.collection('statuses');

  Future<List<Status>> getAllStatuses() async {
    try {
      QuerySnapshot querySnapshot = await _statusesCollection.get();

      final allData = querySnapshot.docs.map((doc) {
        final Map<dynamic, dynamic> data = doc.data() as Map<dynamic, dynamic>;
        data['id'] = doc.id;
        return data;
      }).toList();

      final convertedData = allData.map((item) => Status.fromJson(item)).toList();
      convertedData.sort((a, b) => b.createdTime.toDate().compareTo(a.createdTime.toDate()));

      return convertedData;
    } catch (e) {
      print('Error fetching all statuses: $e');
      // You can choose to return an empty list or throw the error depending on your application's logic
      return []; // Return an empty list in case of error
      // throw e; // Throw the error to be handled by the caller
    }
  }

  Future<Status?> getStatusById(String statusId) async {
    try {
      final DocumentSnapshot snapshot =
      await _statusesCollection.doc(statusId).get();

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