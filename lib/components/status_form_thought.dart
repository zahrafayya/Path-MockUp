import 'package:flutter/material.dart';

class StatusFormThought extends StatelessWidget {
  final String? thought;
  final ValueChanged<String> onChangedThought;

  const StatusFormThought({
    Key? key,
    this.thought,
    required this.onChangedThought,
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
              'I\'m currently think about -',
              style: TextStyle(
                height: 2.5,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            buildTitle(),
          ],
        ),
      )
  );

  Widget buildTitle() => TextFormField(
    maxLines: 1,
    initialValue: thought,
    decoration: const InputDecoration(
      border: OutlineInputBorder(),
      hintText: 'Write your thought here.',
      hintStyle: TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.normal
    ),
    ),
    validator: (locationName) => locationName != null && locationName.isEmpty ? 'The location cannot be empty' : null,
    onChanged: onChangedThought,
  );
}

