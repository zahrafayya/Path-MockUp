import 'package:flutter/material.dart';
import 'package:path_mock_up/model/status.dart';

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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start, // Ensure children are aligned to the start
          children: [
            Text(
              status.statusType,
              style: TextStyle(
                height: 2.5,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              status.status,
              style: TextStyle(
                height: 2.5,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),

            Text(
              status.createdTime.toDate().toString(),
              style: TextStyle(
                height: 2.5,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              children: [
                ElevatedButton(
                    onPressed: () => onUpdatePressed(),
                    child: Text('Edit')
                ),
                ElevatedButton(
                    onPressed: () => onDeletePressed(),
                    child: Text('Delete')
                ),
                ElevatedButton(
                    onPressed: () => {},
                    child: Text('View Comments')
                ),
              ],
            ),
          ],
        ),
      )
  );

}

