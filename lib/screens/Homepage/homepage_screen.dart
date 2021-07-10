import 'package:flutter/material.dart';

import 'package:physiotherapy/screens/dashboard/dashboard.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    Dashboard(),
    Dashboard(),
    Dashboard(),
    Dashboard()
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
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Settings",
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
