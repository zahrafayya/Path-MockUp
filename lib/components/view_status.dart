import 'package:flutter/material.dart';
import 'package:path_mock_up/model/status.dart';
import 'package:intl/intl.dart';

class ViewStatus extends StatelessWidget {
  final Status status;
  final void Function() onDeletePressed;
  final void Function() onUpdatePressed;

  const ViewStatus({
    Key? key,
    required this.status,
    required this.onDeletePressed,
    required this.onUpdatePressed,
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
                    alignment: Alignment.center, // Center align the children in the Stack
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
                          // color: Colors.yellow,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3), // Shadow color
                                  spreadRadius: 3, // Spread radius
                                  blurRadius: 5, // Blur radius
                                  offset: Offset(0, 2), // Offset in x and y direction
                                ),
                              ],
                          ),
                          child:
                          Center(
                            child: status.statusType == 'Sleep'
                            ? Icon(
                              Icons.bedtime_sharp,
                              size: 20,
                              color: Colors.greenAccent.shade200,
                            )
                            : status.statusType == 'Thought'
                            ? Icon(
                              Icons.format_quote_sharp,
                              size: 20,
                              color: Colors.orangeAccent.shade200,
                            )
                            : status.statusType == 'Music'
                            ? Icon(
                              Icons.music_note_sharp,
                              size: 20,
                              color: Colors.deepPurpleAccent.shade200,
                            )
                            : status.statusType == 'Location'
                            ? Icon(
                              Icons.location_pin,
                              size: 20,
                              color: Colors.blueAccent.shade200,
                            )
                            : SizedBox()
                          ),
                        )
                      ),
                    ],
                  ),
                  SizedBox(width: 28),
                  Container(
                    margin: EdgeInsets.only(top: 14, bottom: 10),
                    padding: EdgeInsets.only(left: 10, right: 10, top: 4),
                    width: 260,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50, // Grey background color
                      borderRadius: BorderRadius.circular(10), // Rounded corners
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3), // Shadow color
                          spreadRadius: 1, // Spread radius
                          blurRadius: 4, // Blur radius
                          offset: Offset(0, 4), // Offset in x and y direction
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (status.statusType == 'Location') RichText(
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
                            TextSpan(
                              text: ' has checked in at ',
                            ),
                            TextSpan(
                                text: status.status,
                                style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      )
                        else if (status.statusType == 'Thought') RichText(
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
                              TextSpan(
                                text: ' says ',
                              ),
                              TextSpan(
                                text: status.status,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )
                        else if (status.statusType == 'Music') RichText(
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
                                TextSpan(
                                  text: ' is listening to ',
                                ),
                                TextSpan(
                                  text: status.status,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        SizedBox(height: 8),
                        Text(
                          DateFormat('d MMMM y HH:mm').format(status.createdTime.toDate()),
                          style: TextStyle(
                            height: 2.5,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade600
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => {},
                              icon: Icon(Icons.mode_comment_outlined, size: 16)
                            ),
                            IconButton(
                              onPressed: () => onUpdatePressed(),
                              icon: Icon(Icons.mode_edit_outlined, size: 16),
                            ),
                            IconButton(
                              onPressed: () => onDeletePressed(),
                              icon: Icon(Icons.delete_outline, size: 16),
                            ),
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

}

