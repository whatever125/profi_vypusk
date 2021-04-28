import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'dart:math';


void main() {
  timeDilation = 1.5;
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PROFIВЫБОР',
      home: TabsPage(),
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.white,
        textTheme: TextTheme(
          headline6: TextStyle(fontSize: 36.0),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.system,
    );
  }
}


class TabsPage extends StatefulWidget {
  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TabNavigationItem.items[_currentIndex].label),
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
            )
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}


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
      page: Feed(),
      label: "Лента",
      activeIcon: Icon(Icons.home),
      icon: Icon(Icons.home_outlined),
    ),
    TabNavigationItem(
      page: Search(),
      label: "Поиск",
      activeIcon: Icon(Icons.search),
      icon: Icon(Icons.search_outlined),
    ),
    TabNavigationItem(
      page: Profile(),
      label: "Профиль",
      activeIcon: Icon(Icons.person),
      icon: Icon(Icons.person_outlined),
    ),
  ];
}


class Feed extends StatefulWidget {
  @override
  FeedState createState() => FeedState();
}


class FeedState extends State<Feed> {
  final _events = [];
  final _biggerFont = TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildFeed(),
    );
  }

  Widget _buildFeed() {
    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();
        final index = i ~/ 2;
        if (index >= _events.length) {
          Random random = new Random();
          _events.add(random.nextInt(1000000));
        }
        return _buildRow(_events[index]);
      }
    );
  }

  Widget _buildRow(int x) {
    return ListTile(
      title: Text(
        x.toString(),
        style: _biggerFont,
      ),
    );
  }
}


class Search extends StatelessWidget {
  static final String routeName = '/search';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Search',
          style: TextStyle(
            fontSize: 24.0
          )
        ),
      ),
    );
  }
}


class Favorite extends StatelessWidget {
  static final String routeName = '/favorite';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Favorites',
          style: TextStyle(
            fontSize: 24.0
          )
        ),
      ),
    );
  }
}


class Profile extends StatelessWidget {
  static final String routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Profile',
          style: TextStyle(
            fontSize: 24.0,
          )
        ),
      ),
    );
  }
}


class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text('Иванов Иван'),
                  accountEmail: Text('ivanov@ivan.org'),
                  currentAccountPicture: CircleAvatar(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    child: Text('ИИ')
                  ),
                ),
                ListTile(
                  title: Text('Избранное'),
                  leading: Icon(Icons.star_outline),
                  onTap: () => {Navigator.of(context).pop()},
                ),
                ListTile(
                  title: Text('Настройки'),
                  leading: Icon(Icons.settings_outlined),
                  onTap: () => {Navigator.of(context).pop()},
                ),
                ListTile(
                  title: Text('Помощь'),
                  leading: Icon(Icons.help_outline),
                  onTap: () => {Navigator.of(context).pop()},
                ),
              ],
            ),
          ),
          Container(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Divider(),
                    ListTile(
                      title: Text('Выйти'),
                      leading: Icon(Icons.logout),
                      onTap: () => {Navigator.of(context).pop()},
                    ),
                  ],
                )
              )
            )
          )
        ],
      ),
    );
  }
}
