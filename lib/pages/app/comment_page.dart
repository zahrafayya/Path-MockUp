import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:path_mock_up/model/profile.dart';
import 'package:path_mock_up/model/status.dart';
import 'package:path_mock_up/model/comment.dart';
import 'package:path_mock_up/repositories/profile.repository.dart';
import 'package:path_mock_up/repositories/status_repository.dart';
import 'package:path_mock_up/repositories/comment_repository.dart';
import 'package:intl/intl.dart';

class CommentPage extends StatefulWidget {
  final String userId;
  final String postId;

  const CommentPage({super.key, required this.userId, required this.postId});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final TextEditingController _commentController = TextEditingController();
  final CommentRepository _commentRepository = CommentRepository();
  final List<Comment> _comments = [];
  late Status statusObj;
  late Profile profileObj;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getStatus();
    _loadComments();
  }

  Future getStatus() async {
    await StatusRepository().getStatusById(widget.postId).then((Status? fetchedStatus) {
      setState(() {
        if (fetchedStatus != null) {
          statusObj = fetchedStatus;
        }
      });
      });
    await FirebaseFirestore.instance.collection('profiles').doc(statusObj.profileId).get().then((DocumentSnapshot profileSnapshot) {
      setState(() {
        if (profileSnapshot.exists) {
          statusObj.profile = Profile.fromJson(profileSnapshot.data() as Map<String, dynamic>);
        }
      });
    });
    await ProfileRepository().getProfileById(statusObj.profileId).then((Profile? fetchedProfile){
      setState(() {
        if (fetchedProfile != null) {
          profileObj = fetchedProfile;
        }
      });
    });
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _loadComments() async {
    final comments = await _commentRepository.getComments(widget.postId);
    setState(() {
      _comments.addAll(comments);
    });
  }

  Future<void> _addComment() async {
    final newComment = Comment(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: _commentController.text,
      createdTime: DateTime.now(),
      userId: widget.userId,
      postId: widget.postId,
    );

    await _commentRepository.addComment(newComment);
    setState(() {
      _comments.add(newComment);
      _commentController.clear();
    });
  }

  Future<void> _updateComment(String id, String newText) async {
    await _commentRepository.updateComment(id, newText);
    setState(() {
      final index = _comments.indexWhere((comment) => comment.id == id);
      if (index != -1) {
        _comments[index] = Comment(
          id: _comments[index].id,
          text: newText,
          createdTime: _comments[index].createdTime,
          userId: _comments[index].userId,
          postId: _comments[index].postId,
        );
      }
    });
  }

  Future<void> _deleteComment(String id) async {
    await _commentRepository.deleteComment(id);
    setState(() {
      _comments.removeWhere((comment) => comment.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
        title: const Text(
          'Comment',
          style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500
          ),
        ),
        backgroundColor: Color(0xFFC03027),
      ),
      body: isLoading?
        Center(
          child: const CircularProgressIndicator(
            color: Colors.grey,
          ),
        ) : Column(
        children: [
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 3,
                      color: Colors.grey.shade300,
                    ),
                    Positioned(
                      top: 14,
                      child: Container(
                        height: 27,
                        width: 27,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 3,
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: getStatusIcon(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 28),
                Container(
                  margin: EdgeInsets.only(top: 14, bottom: 10),
                  padding: EdgeInsets.only(left: 10, right: 10, top: 6),
                  width: 260,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getStatusText(),
                      SizedBox(height: 8),
                      Text(
                        DateFormat('d MMMM y HH:mm').format(statusObj.createdTime.toDate()),
                        style: TextStyle(
                          height: 2.5,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: const InputDecoration(
                      hintText: 'Type to comment',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _addComment,
                  child: const Text('Send'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _comments.length,
              itemBuilder: (context, index) {
                final comment = _comments[index];
                String username = '';
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: Card(
                    child: FutureBuilder(
                      future: ProfileRepository().getProfileByUserId(_comments[index].userId),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          username = 'Loading';
                        } else if (snapshot.hasError) {
                          username = 'Error';
                        } else {
                          username = snapshot.data?.username ?? 'Anonymous';
                        }
                        return ListTile(
                          isThreeLine: true,
                          title: Text(
                            '${comment.text}',
                          ),
                          subtitle: Row(
                            children: [
                              Text(
                                '${username}',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                ' at ${comment.createdTime.year}-${comment.createdTime.month}-${comment.createdTime.day} ${comment.createdTime.hour}:${comment.createdTime.minute}',
                                style: TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              (comment.userId == widget.userId)?
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      final TextEditingController _editController =
                                      TextEditingController(text: comment.text);
                                      return AlertDialog(
                                        title: const Text('Update Comment'),
                                        content: TextField(
                                          controller: _editController,
                                          decoration: const InputDecoration(
                                            hintText: 'Edit your comment',
                                          ),
                                        ),
                                        actions: [
                                          ElevatedButton(
                                            onPressed: () {
                                              _updateComment(comment.id, _editController.text);
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Update'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ) : Text(''),
                              (comment.userId == widget.userId || this.profileObj?.userId == widget.userId)?
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () => _deleteComment(comment.id),
                              ) : Text(''),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget getStatusIcon() {
    switch (statusObj.statusType) {
      case 'Sleep':
        return Icon(
          Icons.bedtime_sharp,
          size: 20,
          color: Colors.green.shade400,
        );
      case 'Thought':
        return Icon(
          Icons.format_quote_sharp,
          size: 20,
          color: Colors.orangeAccent.shade200,
        );
      case 'Music':
        return Icon(
          Icons.music_note_sharp,
          size: 20,
          color: Colors.deepPurpleAccent.shade200,
        );
      case 'Location':
        return Icon(
          Icons.location_pin,
          size: 20,
          color: Colors.blueAccent.shade200,
        );
      default:
        return SizedBox();
    }
  }

  Widget getStatusText() {
    switch (statusObj.statusType) {
      case 'Location':
        return RichText(
          text: TextSpan(
            style: TextStyle(
              height: 1.5,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black.withOpacity(0.8),
            ),
            children: [
              TextSpan(
                text: statusObj.profile?.username,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: ' has checked in at '),
              TextSpan(
                text: statusObj.status,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      case 'Thought':
        return RichText(
          text: TextSpan(
            style: TextStyle(
              height: 1.5,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black.withOpacity(0.8),
            ),
            children: [
              TextSpan(
                text: statusObj.profile?.username,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: ' says '),
              TextSpan(text: statusObj.status),
            ],
          ),
        );
      case 'Music':
        return RichText(
          text: TextSpan(
            style: TextStyle(
              height: 1.5,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black.withOpacity(0.8),
            ),
            children: [
              TextSpan(
                text: statusObj.profile?.username,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: ' is listening to '),
              TextSpan(
                text: statusObj.status,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      case 'Sleep':
        return RichText(
          text: TextSpan(
            style: TextStyle(
              height: 1.5,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black.withOpacity(0.8),
            ),
            children: [
              TextSpan(
                text: statusObj.profile?.username,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: ' is '),
              TextSpan(text: statusObj.status),
            ],
          ),
        );
      default:
        return SizedBox();
    }
  }
}