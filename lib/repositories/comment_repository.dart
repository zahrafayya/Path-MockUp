import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_mock_up/model/comment.dart';

class CommentRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addComment(Comment comment) async {
    await _firestore.collection('comments').doc(comment.id).set({
      'id': comment.id,
      'text': comment.text,
      'createdTime': comment.createdTime.toIso8601String(),
      'userId': comment.userId,
      'postId': comment.postId,
    });
  }

  Future<void> updateComment(String id, String newText) async {
    await _firestore.collection('comments').doc(id).update({
      'text': newText,
    });
  }

  Future<void> deleteComment(String id) async {
    await _firestore.collection('comments').doc(id).delete();
  }

  Future<List<Comment>> getComments(String postId) async {
    final querySnapshot = await _firestore
        .collection('comments')
        .where('postId', isEqualTo: postId)
        .orderBy('createdTime')
        .get();
    return querySnapshot.docs.map((doc) {
      final data = doc.data();
      return Comment(
        id: data['id'],
        text: data['text'],
        createdTime: DateTime.parse(data['createdTime']),
        userId: data['userId'],
        postId: data['postId'],
      );
    }).toList();
  }
}