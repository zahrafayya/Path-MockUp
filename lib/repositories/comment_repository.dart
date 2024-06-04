import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_mock_up/model/comment.dart';

class CommentRepository {
  final db = FirebaseFirestore.instance;

  CollectionReference _commentsCollection = FirebaseFirestore.instance.collection('comments');

  Future<Comment?> getCommentById(String commentId) async {
    try {
      final DocumentSnapshot snapshot =
      await _commentsCollection.doc(commentId).get();

      if (snapshot.exists) {
        final Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        data['id'] = snapshot.id;
        return Comment.fromJson(data);
      } else {
        return null;
      }
    } catch (e) {
      print('Error getting Comment by ID: $e');
      return null;
    }
  }

  Future<void> createComment(Comment comment) async {
    try {
      Map<String, dynamic> commentData = comment.toJson();

      await _commentsCollection.add(commentData);

      print('Comment created successfully');
    } catch (e) {
      print('Error creating Comment: $e');
      // You can choose to throw the error to be handled by the caller if needed
      throw e;
    }
  }

  Future<void> deleteComment(String commentId) async {
    try {
      await _commentsCollection.doc(commentId).delete();
    } catch (e) {
      print('Error deleting Comment: $e');
    }
  }
}