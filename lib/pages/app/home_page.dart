import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
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
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFFC03027),
        children: [
          SpeedDialChild(
              child: const Icon(Icons.add)
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomNavbar(currentPage: 'Home'),
    );
  }
}
