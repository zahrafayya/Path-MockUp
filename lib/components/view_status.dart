import 'package:flutter/material.dart';
import 'package:path_mock_up/model/status.dart';
import 'package:intl/intl.dart';

class ViewStatus extends StatelessWidget {
  final Status status;
  final void Function() onCommentPressed;
  final void Function() onDeletePressed;
  final void Function() onUpdatePressed;
  final String currentUserId; // Add this to get the current user's ID

  const ViewStatus({
    Key? key,
    required this.status,
    required this.onCommentPressed,
    required this.onDeletePressed,
    required this.onUpdatePressed,
    required this.currentUserId, // Add this to the constructor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IntrinsicHeight(
          child: Row(
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
                      DateFormat('d MMMM y HH:mm').format(status.createdTime.toDate()),
                      style: TextStyle(
                        height: 2.5,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: onCommentPressed,
                          icon: Icon(Icons.mode_comment_outlined, size: 16),
                        ),
                        if (currentUserId == status.profile?.userId) ...[
                          IconButton(
                            onPressed: onUpdatePressed,
                            icon: Icon(Icons.mode_edit_outlined, size: 16),
                          ),
                          IconButton(
                            onPressed: onDeletePressed,
                            icon: Icon(Icons.delete_outline, size: 16),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget getStatusIcon() {
    switch (status.statusType) {
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
    switch (status.statusType) {
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
                text: status.profile?.username,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: ' has checked in at '),
              TextSpan(
                text: status.status,
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
                text: status.profile?.username,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: ' says '),
              TextSpan(text: status.status),
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
                text: status.profile?.username,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: ' is listening to '),
              TextSpan(
                text: status.status,
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
                text: status.profile?.username,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: ' is '),
              TextSpan(text: status.status),
            ],
          ),
        );
      default:
        return SizedBox();
    }
  }
}
