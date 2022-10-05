import 'package:flutter/material.dart';
import 'package:share_app/style/config.dart';

import '../tab/index_page.dart';
import '../tab/user_page.dart';

class Tabs extends StatefulWidget {
  const Tabs({Key? key}) : super(key: key);

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _currentIndex = 0;
  final List _pageList = [
    const IndexPage(),
    const IndexPage(),
    const UserPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageList[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        iconSize: 36.0,
        fixedColor: Config.primaryColor,
        unselectedItemColor: Colors.grey.shade400,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "首页"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border), label: "投稿"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: "我的"),
        ],
      ),
    );
  }
}
