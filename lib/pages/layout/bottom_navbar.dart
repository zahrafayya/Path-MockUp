import 'package:flutter/material.dart';
import 'package:path_mock_up/pages/app/home_page.dart';
import 'package:path_mock_up/pages/app/search_page.dart';
import 'package:path_mock_up/pages/app/profile_page.dart';

class BottomNavbar extends StatelessWidget {

  const BottomNavbar({
    super.key,
    required this.currentPage
  });

  final String currentPage;

  void changePage(BuildContext context, String newPage) {
    if (newPage != currentPage) {
      switch (newPage) {
        case 'Search':
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SearchPage()),
          );
        case 'Home':
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        case 'Profile':
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ProfilePage()),
          );
        default:
          return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 72,
      color: Color(0xFFBF1910),
      notchMargin: 5,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 28.0), // Add margin to the Container
                child: IconButton(
                  iconSize: 32,
                  icon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    this.changePage(context, 'Search');
                  },
                ),
              ),
              const Text(
                'Search',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 28.0), // Add margin to the Container
                child: IconButton(
                  iconSize: 32,
                  icon: const Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    this.changePage(context, 'Home');
                  },
                ),
              ),
              const Text(
                'Home',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 28.0), // Add margin to the Container
                child: IconButton(
                  iconSize: 32,
                  icon: const Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    this.changePage(context, 'Profile');
                  },
                ),
              ),
              const Text(
                'Profile',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
