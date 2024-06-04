import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:path_mock_up/components/view_status.dart';
import 'package:path_mock_up/pages/app/detail_status_page.dart';
import 'package:path_mock_up/repositories/status_repository.dart';
import '../layout/bottom_navbar.dart';
import 'package:path_mock_up/model/status.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  final db = FirebaseFirestore.instance;

  late List<Status> allStatus = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    refreshStatuses();
  }

  Future refreshStatuses() async {
    setState(() => isLoading = true);

    await StatusRepository().getAllStatuses().then((statuses) {
      setState(() {
        allStatus = statuses;
      });
    });

    setState(() => isLoading = false);
  }

  Future deleteStatus(String id) async {
    await StatusRepository().deleteStatus(id);

    await refreshStatuses();
  }

  // sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  void detailStatusChangePage(String statusType, String id) {
    Navigator.push(
      context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              DetailStatusPage(
                  statusType: statusType,
                  refreshStatuses: () => { refreshStatuses() },
                  pkid: id
              ),
          transitionDuration: Duration(milliseconds: 300),
          reverseTransitionDuration: Duration(milliseconds: 300),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset(0.0, 0.0);
            const curve = Curves.ease;

            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset('lib/images/path_text.png', height: 24),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu, color: Colors.white, size: 30),
        ),
        backgroundColor: Color(0xFFC03027),
      ),
      body: isLoading
          ? Center(
            child: const CircularProgressIndicator(
              color: Colors.grey,
            ),
          )
          : allStatus.isEmpty
          ? Center(
            child: const Text(
            'No status to show.',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        )
          : showStatuses(),
      floatingActionButton: ExpandableFab(
        fanAngle: 105,
        openButtonBuilder: RotateFloatingActionButtonBuilder(
          child: const Icon(
              Icons.add, size: 30,
          ),
          fabSize: ExpandableFabSize.regular,
          foregroundColor: Colors.white,
          backgroundColor: Colors.black,
          shape: const CircleBorder(),
        ),
        closeButtonBuilder: RotateFloatingActionButtonBuilder(
          child: const Icon(Icons.close),
          fabSize: ExpandableFabSize.regular,
          foregroundColor: Colors.white,
          backgroundColor: Colors.black,
          shape: const CircleBorder(),
        ),
        children: [
          FloatingActionButton.small(
            heroTag: null,
            backgroundColor: Colors.black,
            shape: const CircleBorder(),
            child: const Icon(Icons.bedtime_sharp, color: Colors.white,),
            onPressed: () {},
          ),
          FloatingActionButton.small(
            heroTag: null,
            backgroundColor: Colors.black,
            shape: const CircleBorder(),
            child: const Icon(Icons.format_quote_sharp, color: Colors.white,),
            onPressed: () => detailStatusChangePage('Thought', ''),
          ),
          FloatingActionButton.small(
            heroTag: null,
            backgroundColor: Colors.black,
            shape: const CircleBorder(),
            child: const Icon(Icons.music_note_sharp, color: Colors.white,),
            onPressed: () => detailStatusChangePage('Music', ''),
          ),
          FloatingActionButton.small(
            heroTag: null,
            backgroundColor: Colors.black,
            shape: const CircleBorder(),
            child: const Icon(Icons.location_pin, color: Colors.white,),
            onPressed: () => detailStatusChangePage('Location', ''),
          ),
          FloatingActionButton.small(
            heroTag: null,
            backgroundColor: Colors.black,
            shape: const CircleBorder(),
            child: const Icon(Icons.camera_alt_sharp, color: Colors.white,),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      bottomNavigationBar: BottomNavbar(currentPage: 'Home'),
    );
  }

  Widget showStatuses() => ListView.builder(
    itemCount: allStatus.length,
    itemBuilder: (context, index) {
      final status = allStatus[index];

      return Container(
          child: ViewStatus(
              status: status,
              onDeletePressed: () => {
                if (status.id != null) deleteStatus(status.id!)
              },
              onUpdatePressed: () => {
                if (status.id != null) detailStatusChangePage(status.statusType, status.id!)
              }
          )
      );

    },
  );

}
