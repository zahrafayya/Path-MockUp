import 'package:flutter/material.dart';
import '../layout/bottom_navbar.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Page"),
      ),
      body: Center(
        child: Text("Profile Content"),
      ),
      bottomNavigationBar: BottomNavbar(currentPage: 'Profile'),
    );
  }
}
