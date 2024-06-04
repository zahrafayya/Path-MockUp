import 'package:flutter/material.dart';
import 'package:path_mock_up/components/status_form_location.dart';
import 'package:path_mock_up/components/status_form_music.dart';
import 'package:path_mock_up/components/status_form_thought.dart';

class CreateStatusPage extends StatefulWidget {
  final String statusType;
  final String pkid;

  CreateStatusPage({super.key, required this.statusType, this.pkid = ''});

  _CreateStatusPageState createState() => _CreateStatusPageState();
}

class _CreateStatusPageState extends State<CreateStatusPage> {
  final _formKey = GlobalKey<FormState>();
  late String status;
  bool isFormValid = false;

  @override
  Widget build(BuildContext context) {
    Widget statusForm;

    if (widget.statusType == 'Location') {
      statusForm = StatusFormLocation(
        onChangedLocationName: (status) {
          setState(() {
            this.status = status;
            if (status.isNotEmpty) isFormValid = true;
            else isFormValid = false;
          });
        },
      );
    } else if (widget.statusType == 'Music') {
      statusForm = StatusFormMusic(
        onChangedMusic: (title, artist) {
          setState(() {
            this.status = title + ' - ' + artist;
            isFormValid = title.isNotEmpty && artist.isNotEmpty;
            print(title);
            print(artist);
          });
        },
      );
    } else if (widget.statusType == 'Thought') {
      statusForm = StatusFormThought(
        onChangedThought: (status) {
          setState(() {
            this.status = status;
            isFormValid = status.isNotEmpty;
          });
        },
      );
    } else {
      statusForm = Center(child: Text('Unknown status type'));
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        centerTitle: true,
        title: Text(
          'New Status',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500
          ),
        ),
        backgroundColor: Color(0xFFC03027),
        actions: [buildButton()],
      ),
      body: statusForm,
    );
  }

  Widget buildButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: IconButton(
        icon: Icon(
          Icons.save,
          color: isFormValid ? Colors.white : Colors.grey.shade300,
        ),
        onPressed: isFormValid ? addOrUpdateMovie : null,
      ),
    );
  }

  void addOrUpdateMovie() async {
    if (isFormValid) {
      final isUpdating = widget.pkid != '';

      if (isUpdating) {
        // await updateStatus();
      } else {
        // await addStatus();
      }

      Navigator.of(context).pop();
    }
  }

  // Future updateStatus() async {
  //   final movie = widget.movie!.copy(
  //     title: title,
  //     imageUrl: imageUrl,
  //     description: description,
  //   );
  //
  //   await MoviesDatabase.instance.updateMovie(movie);
  // }
  //
  // Future addStatus() async {
  //   final movie = Movie(
  //       title: title,
  //       imageUrl: imageUrl,
  //       description: description,
  //       createdTime: DateTime.now()
  //   );
  //
  //   await MoviesDatabase.instance.createMovie(movie);
  // }
}