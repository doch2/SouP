import 'package:flutter/material.dart';
import 'package:soup/screens/profile/my_profile.dart';
import 'package:soup/screens/trade_setting.dart';

import 'home.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();

}

class _MainScreenState extends State<MainScreen> {
  int _selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    List pages = [
      Home(),
      TradeSetting(),
      MyProfile()
    ];

    List<BottomNavigationBarItem> bottomNavigatorItem = [
      BottomNavigationBarItem(
          label: "홈",
          icon: Icon(Icons.home_filled)
      ),
      BottomNavigationBarItem(
          label: "매매 변경",
          icon: Icon(Icons.settings)
      ),
      BottomNavigationBarItem(
          label: "내 정보",
          icon: Icon(Icons.person)
      ),
    ];

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey.withOpacity(0.6),
        selectedFontSize: 12,
        currentIndex: _selectIndex,
        onTap: (int index) {
          setState(() {
            _selectIndex = index;
          });
        },
        items: bottomNavigatorItem,
      ),
      body: pages[_selectIndex]
    );
  }
}