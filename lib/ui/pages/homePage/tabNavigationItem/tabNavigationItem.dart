import 'package:flutter/material.dart';
import 'package:profi_vypusk/ui/pages/homePage/tabNavigationItem/feedTab.dart';
import 'package:profi_vypusk/ui/pages/homePage/tabNavigationItem/searchTab.dart';
import 'package:profi_vypusk/ui/pages/homePage/tabNavigationItem/profileTab/profileTab.dart';

class TabNavigationItem {
  final Widget page;
  final String label;
  final Icon activeIcon;
  final Icon icon;

  TabNavigationItem({
    @required this.page,
    @required this.label,
    @required this.activeIcon,
    @required this.icon,
  });

  static List<TabNavigationItem> get items => [
    TabNavigationItem(
      page: FeedTab(),
      label: "Лента",
      activeIcon: Icon(Icons.home),
      icon: Icon(Icons.home_outlined),
    ),
    TabNavigationItem(
      page: SearchTab(),
      label: "Поиск",
      activeIcon: Icon(Icons.search),
      icon: Icon(Icons.search_outlined),
    ),
    TabNavigationItem(
      page: ProfileTab(),
      label: "Профиль",
      activeIcon: Icon(Icons.person),
      icon: Icon(Icons.person_outlined),
    ),
  ];
}
