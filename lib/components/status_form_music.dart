import 'package:flutter/material.dart';

class StatusFormMusic extends StatefulWidget {
  final String title;
  final String artist;
  final void Function(String title, String artist) onChangedMusic;

  const StatusFormMusic({
    Key? key,
    this.title = '',
    this.artist = '',
    required this.onChangedMusic,
  }) : super(key: key);

  @override
  _StatusFormMusicState createState() => _StatusFormMusicState();
}

class _StatusFormMusicState extends State<StatusFormMusic> {
  late String title;
  late String artist;

  @override
  void initState() {
    super.initState();
    title = widget.title;
    artist = widget.artist;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start, // Ensure children are aligned to the start
          children: [
            const Text(
              'I\'m currently listening to -',
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
  }

  Widget buildTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'Title: ',
            style: TextStyle(fontSize: 16),
          ),
        ),
        TextFormField(
          initialValue: title,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter title',
            hintStyle: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.normal
            ),
          ),
          onChanged: (value) {
            setState(() {
              title = value;
            });
            widget.onChangedMusic(title, artist);
          },
        ),
        const SizedBox(height: 16),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'Artist: ',
            style: TextStyle(fontSize: 16),
          ),
        ),
        TextFormField(
          initialValue: artist,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter artist',
            hintStyle: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.normal
            ),
          ),
          onChanged: (value) {
            setState(() {
              artist = value;
            });
            widget.onChangedMusic(title, artist);
          },
        ),
      ],
    );
  }
}