import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_mock_up/model/profile.dart';

class ProfileRepository {
  final db = FirebaseFirestore.instance;

  CollectionReference _profileCollection = FirebaseFirestore.instance.collection('profiles');

  Future<Profile?> getProfileById(String userId) async {
    try {
      final DocumentSnapshot snapshot =
      await _profileCollection.doc(userId).get();

      if (snapshot.exists) {
        final Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        data['id'] = snapshot.id;
        return Profile.fromJson(data);
      } else {
        return null;
      }
    } catch (e) {
      print('Error getting Comment by ID: $e');
      return null;
    }
  }

  Future<Profile?> getProfileByUserId(String userId) async {
    try {
      QuerySnapshot querySnapshot = await _profileCollection
          .where('userId', isEqualTo: userId)
          .limit(1) // Limit to the first match
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final doc = querySnapshot.docs.first;
        final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return Profile.fromJson(data);
      } else {
        return null; // Return null if no documents found
      }
    } catch (e) {
      print('Error fetching user profile: $e');
      return null; // Return null in case of error
    }
  }
}