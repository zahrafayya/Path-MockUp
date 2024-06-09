import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:path_mock_up/components/status_form_location.dart';
import 'package:path_mock_up/components/status_form_music.dart';
import 'package:path_mock_up/components/status_form_sleep.dart';
import 'package:path_mock_up/components/status_form_thought.dart';
import 'package:path_mock_up/model/profile.dart';
import 'package:path_mock_up/model/status.dart';
import 'package:path_mock_up/pages/app/home_page.dart';
import 'package:path_mock_up/repositories/profile.repository.dart';
import 'package:path_mock_up/repositories/status_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DetailStatusPage extends StatefulWidget {
  final String statusType;
  final void Function() refreshStatuses;
  final String pkid;

  DetailStatusPage({super.key, required this.statusType, required this.refreshStatuses, this.pkid = ''});

  _DetailStatusPageState createState() => _DetailStatusPageState();
}

class _DetailStatusPageState extends State<DetailStatusPage> {
  final _formKey = GlobalKey<FormState>();
  String status = '';
  bool isFormValid = false;
  bool isLoading = true;

  late Status statusObj;

  @override
  void initState() {
    super.initState();

    if (widget.pkid != '') {
      getStatus();
    }
    else setState(() => isLoading = false);
  }

  Future getStatus() async {
    setState(() => isLoading = true);

    await StatusRepository().getStatusById(widget.pkid).then((Status? fetchedStatus) {
      setState(() {
        if (fetchedStatus != null) {
          status = fetchedStatus.status;
          statusObj = fetchedStatus;
        }
      });
    });

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
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
      body: isLoading
          ? Center(
              child: const CircularProgressIndicator(
                color: Colors.grey,
              ),
            )
          : statusForm(),
    );
  }

  Widget statusForm() {
    if (widget.statusType == 'Location') {
      return StatusFormLocation(
        locationName: status,
        onChangedLocationName: (status) {
          setState(() {
            this.status = status;
            if (status.isNotEmpty) isFormValid = true;
            else isFormValid = false;
          });
        },
      );
    } else if (widget.statusType == 'Music') {
      return StatusFormMusic(
        onChangedMusic: (title, artist) {
          setState(() {
            this.status = title + ' - ' + artist;
            isFormValid = title.isNotEmpty && artist.isNotEmpty;
          });
        },
      );
    } else if (widget.statusType == 'Thought') {
      return StatusFormThought(
        thought: status,
        onChangedThought: (status) {
          setState(() {
            this.status = status;
            isFormValid = status.isNotEmpty;
          });
        },
      );
    } else if (widget.statusType == 'Sleep') {
      return StatusFormSleep(
        selectedStatus: status,
        onTriggeredStatus: (status) {
          if (status != '') {
            print(status);
            setState(() {
              this.status = status;
              isFormValid = status.isNotEmpty;
            });
          }
        },
      );
    }

    return Center(child: Text('Unknown status type'));
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
        await updateStatus();
      } else {
        await createStatus();
      }

      widget.refreshStatuses();

      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => HomePage(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    }
  }

  Future<void> updateStatus() async {
    await StatusRepository().updateStatus(
      widget.pkid,
      Status.fromJson({
        "profileId": statusObj.profileId,
        "status": status,
        "statusType": widget.statusType,
        "createdTime": statusObj.createdTime
      })
    );
  }

  Future<void> createStatus() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        Profile? profile = await ProfileRepository().getProfileByUserId(user.uid);

        await StatusRepository().createStatus(
          Status.fromJson({
            "profileId": profile?.id,
            "status": status,
            "statusType": widget.statusType,
            "createdTime": Timestamp.now(),
          }),
        );
      } else {
        print('No user is currently logged in.');
      }

    } catch (e) {
      print(e.toString());
    }
  }
}