import 'package:flutter/material.dart';
import 'package:physiotherapy/screens/chatscreen/chatscreen.dart';

import 'package:physiotherapy/screens/dashboard/dashboard.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:physiotherapy/screens/store/screens/home/store_screen.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    Dashboard(),
    Storescreen(),
    ChatPageView(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //drawer: MyHomepage(),

        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(FlutterIcons.grid_ent),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(FlutterIcons.cart_mco),
              label: 'Store',
            ),
            BottomNavigationBarItem(
              icon: Icon(FlutterIcons.message1_ant),
              label: 'Message',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Color(0xff393939),
          unselectedItemColor: Color(0xffA9A9A9),
          iconSize: 30,
          onTap: _onItemTapped,
          showUnselectedLabels: true,
        ),
      ),
    );
  }
}
