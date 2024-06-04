import 'package:flutter/material.dart';

class Post extends StatefulWidget {
  const Post({super.key});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  final commentTextController = TextEditingController();
  // Create Comment
  void saveComment(String commentText) {
    FirebaseFirestore.instance
        .collection("User Posts")
        .doc(widget.postId)
        .collection("Comments")
        .add({
          "CommentText" : commentText,
          "CommentedBy" : currentUser.email,
          "CommentTime" : Timestamp.now(),
        });
  }

  void createComment() {
    showDialog(
      context: context,
      builder: (context) => AlterDialog(
        title: Text("Add Comment"),
        content: TextField(
          controller: commentTextController,
          decoration: InputDecoration(hintText: "Write a comment"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              saveComment(commentTextController.text);
              Navigator.pop(context);
              commentTextController.clear();
              },
            child: Text("Create"),
          ),

          TextButton(
            onPressed: () {
              Navigator.pop(context);
              commentTextController.clear();
            },
            child: Text("Cancel"),
          ),
        ]
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder(
      // Create Comment Interface
      Column(
        children: [
          CommentButton(onTap: createComment),
          const SizedBox(height: 5),
          Text(
            widget.comments.length.toString(),
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),

      // Read Comment
      StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("User Posts")
            .doc(widget.postId)
            .collection("Comments")
            .orderBy(CommentTime, descending: true)
            .snapshot(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: snapshot.data!.docs.map((doc) {
              final commentData = doc.data() as Map<String, dynamic>;
              return Comment(
                  text: commentData["CommentText"],
                  user: commentData["CommentedBy"],
                  time: commentData["CommentTime"],
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
