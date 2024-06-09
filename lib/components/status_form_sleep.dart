import 'package:flutter/material.dart';

class StatusFormSleep extends StatelessWidget {
  final String selectedStatus;
  final Function(String) onTriggeredStatus;

  const StatusFormSleep({
    Key? key,
    required this.selectedStatus,
    required this.onTriggeredStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Share your sleep plan',
            style: TextStyle(
              height: 2.5,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          buildTitle(),
        ],
      ),
    ),
  );

  Widget buildTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () => onTriggeredStatus('going to sleep'),
          child: Text('I\'m going to sleep'),
          style: ButtonStyle(
            backgroundColor: selectedStatus == 'going to sleep'
                ? MaterialStateProperty.all<Color>(Colors.red.shade100) // Change to desired color
                : MaterialStateProperty.all<Color>(Colors.white),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.black87)// Default color
          ),
        ),
        SizedBox(width: 20),
        ElevatedButton(
        onPressed: () => onTriggeredStatus('just recently awake'),
          child: Text('I recently awake'),
          style: ButtonStyle(
            backgroundColor: selectedStatus == 'just recently awake'
                ? MaterialStateProperty.all<Color>(Colors.red.shade100) // Change to desired color
                : MaterialStateProperty.all<Color>(Colors.white),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.black87)// Default color
          ),
        ),
      ],
    );
  }
}
