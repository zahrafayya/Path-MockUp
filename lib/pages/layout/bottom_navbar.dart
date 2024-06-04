import 'package:flutter/material.dart';
import 'package:path_mock_up/pages/app/home_page.dart';
import 'package:path_mock_up/pages/app/search_page.dart';
import 'package:path_mock_up/pages/app/profile_page.dart';

class BottomNavbar extends StatelessWidget {
  final String currentPage;

  const BottomNavbar({
    super.key,
    required this.currentPage
  });

  void changePage(BuildContext context, String newPage) {
    if (newPage != currentPage) {
      switch (newPage) {
        case 'Search':
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => SearchPage(),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        case 'Home':
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => HomePage(),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        case 'Profile':
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => ProfilePage(),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        default:
          return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      height: 60,
      color: Color(0xFFC03027),
      notchMargin: 5,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            child: Column(
              children: <Widget>[
                const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                const Text(
                  'Search',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 11
                  ),
                ),
              ],
            ),
            onTap: () {
              this.changePage(context, 'Search');
            }
          ),
          GestureDetector(
              child: Column(
                children: <Widget>[
                  const Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  const Text(
                    'Home',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 11
                    ),
                  ),
                ],
              ),
              onTap: () {
                this.changePage(context, 'Home');
              }
          ),
          GestureDetector(
              child: Column(
                children: <Widget>[
                  const Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  const Text(
                    'Profile',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 11
                    ),
                  ),
                ],
              ),
              onTap: () {
                this.changePage(context, 'Profile');
              }
          ),
        ],
      ),
    );
  }
}
