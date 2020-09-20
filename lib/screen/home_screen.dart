import 'package:flutter/material.dart';
import 'package:stream_radio_api/export_path.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    new RadioScreen(
      isFavoriteOnly: false,
    ),
    //new FavoriteScreen()
    new FavoriteScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
      child: Scaffold(
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: HexColor("#182545"),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: HexColor("#ffffff"),
          showUnselectedLabels: false,
          currentIndex: _currentIndex,
          items: [
            _bottomeNavItem(Icons.play_arrow, "Listen"),
            _bottomeNavItem(Icons.favorite, "Favorate")
          ],
          onTap: onTabTapped,
        ),
      ),
    );
  }

  _bottomeNavItem(IconData iconData, String title) {
    return BottomNavigationBarItem(
        icon: new Icon(
          iconData,
          color: HexColor("#6d7381"),
        ),
        activeIcon: new Icon(
          iconData,
          color: HexColor("#ffffff"),
        ),
        label: title);
  }

  void onTabTapped(int index) {
    if (!mounted) return;
    setState(() {
      _currentIndex = index;
    });
  }
}
