import 'package:flutter/material.dart';

class StatusFormLocation extends StatelessWidget {
  final String? locationName;
  final ValueChanged<String> onChangedLocationName;

  const StatusFormLocation({
    Key? key,
    this.locationName = '',

    required this.onChangedLocationName,
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
              'I\'m currently at -',
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
    initialValue: locationName,
    decoration: const InputDecoration(
      hintText: 'Write the location name here.',
      hintStyle: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.normal
      ),
      border: OutlineInputBorder(),
    ),
    validator: (locationName) => locationName != null && locationName.isEmpty ? 'The location cannot be empty' : null,
    onChanged: onChangedLocationName,
  );
}

