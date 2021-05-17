import 'package:flutter/material.dart';
import 'package:profi_vypusk/ui/pages/homePage/navDrawer.dart';
import 'file:///C:/Users/kolma/AndroidStudioProjects/profi_vypusk/lib/ui/pages/homePage/tabNavigationItem/tabNavigationItem.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowGlow();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            TabNavigationItem.items[_currentIndex].label,
          ),
        ),
        drawer: NavDrawer(),
        body: IndexedStack(
          index: _currentIndex,
          children: [
            for (final tabItem in TabNavigationItem.items) tabItem.page,
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (int index) => setState(() => _currentIndex = index),
          items: [
            for (final tabItem in TabNavigationItem.items)
              BottomNavigationBarItem(
                icon: tabItem.icon,
                activeIcon: tabItem.activeIcon,
                label: tabItem.label,
              ),
          ],
        ),
      ),
    );
  }
}