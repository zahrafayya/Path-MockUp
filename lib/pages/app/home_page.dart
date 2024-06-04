import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:path_mock_up/pages/app/create_status_page.dart';
import '../layout/bottom_navbar.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  // sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  void createStatusChangePage(String statusType) {
    Navigator.push(
      context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => CreateStatusPage(statusType: statusType),
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
      body: Center(
        child: Text("Home Content"),

      ),
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
            onPressed: () => createStatusChangePage('Thought'),
          ),
          FloatingActionButton.small(
            heroTag: null,
            backgroundColor: Colors.black,
            shape: const CircleBorder(),
            child: const Icon(Icons.music_note_sharp, color: Colors.white,),
            onPressed: () => createStatusChangePage('Music'),
          ),
          FloatingActionButton.small(
            heroTag: null,
            backgroundColor: Colors.black,
            shape: const CircleBorder(),
            child: const Icon(Icons.location_pin, color: Colors.white,),
            onPressed: () => createStatusChangePage('Location'),
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
}
