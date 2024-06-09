import 'package:flutter/material.dart';
import '../layout/bottom_navbar.dart';

class SearchPage extends StatefulWidget {
  SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Page"),
      ),
      body: Center(
        child: Text("Search Content"),
      ),
      bottomNavigationBar: BottomNavbar(currentPage: 'Search'),
    );
  }
}
