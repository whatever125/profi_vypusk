import 'package:flutter/material.dart';
import 'package:profi_vypusk/vacancyTab.dart';
import 'package:profi_vypusk/eventTab.dart';
import 'package:profi_vypusk/employerTab.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final List<Tab> tabs = <Tab>[
    Tab(text: "Вакансии"),
    Tab(text: "Мероприятия"),
    Tab(text: "Работодатели"),
  ];

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowGlow();
      },
      child: DefaultTabController(
        length: tabs.length,
        child: Builder(builder: (BuildContext context) {
          final TabController tabController = DefaultTabController.of(context);
          tabController.addListener(() {
            if (!tabController.indexIsChanging) {}
          });
          return Scaffold(
            appBar: AppBar(
              title: Text("Избранное"),
              bottom: TabBar(
                tabs: tabs,
              ),
            ),
            body: TabBarView(
              children: [
                VacancyTab(),
                EventTab(),
                EmployerTab(),
              ],
            ),
          );
        }),
      ),
    );
  }
}
