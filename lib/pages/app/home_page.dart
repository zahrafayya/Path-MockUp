import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
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
            onPressed: () {},
          ),
          FloatingActionButton.small(
            heroTag: null,
            backgroundColor: Colors.black,
            shape: const CircleBorder(),
            child: const Icon(Icons.music_note_sharp, color: Colors.white,),
            onPressed: () {},
          ),
          FloatingActionButton.small(
            heroTag: null,
            backgroundColor: Colors.black,
            shape: const CircleBorder(),
            child: const Icon(Icons.location_pin, color: Colors.white,),
            onPressed: () {},
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
