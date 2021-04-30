import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:http/http.dart' as http;
import 'dart:convert';


void main() {
  timeDilation = 1.5;
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PROFIВЫПУСК',
      home: TabsPage(),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
    );
  }
}


class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Color(0xFFFFFFFF),
    accentColor: Color(0xFF1DA1F2),
    backgroundColor: Color(0xFFFFFFFF),
    scaffoldBackgroundColor: Color(0xFFFFFFFF),
    canvasColor: Color(0xFFFFFFFF),
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(
        color: Color(0xFF1DA1F2),
      ),
    ),
    iconTheme: IconThemeData(
      color: Color(0xFF5B7083),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Color(0xFF1DA1F2),
      unselectedItemColor: Color(0xFF5B7083),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Color(0xFF15202B),
    accentColor: Color(0xFF1DA1F2),
    backgroundColor: Color(0xFF15202B),
    scaffoldBackgroundColor: Color(0xFF15202B),
    canvasColor: Color(0xFF15202B),
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(
        color: Color(0xFF1DA1F2),
      ),
    ),
    iconTheme: IconThemeData(
      color: Color(0xFF8899A6),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Color(0xFF1DA1F2),
      unselectedItemColor: Color(0xFF8899A6),
    ),
  );
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
  Future<List<dynamic>> data;

  @override
  void initState() {
    super.initState();
    data = fetchFeed();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildFeed(),
    );
  }

  Widget _buildFeed() {
    return Container(
      child: FutureBuilder<List<dynamic>>(
        future: data,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return RefreshIndicator(
            child: _listView(snapshot),
            onRefresh: _pullRefresh,
          );
        }
      )
    );
  }

  Widget _listView(AsyncSnapshot snapshot) {
    if (snapshot.hasData) {
      return ListView.builder(
          shrinkWrap: false,
          padding: EdgeInsets.all(16.0),
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            if (index.isOdd) return Divider();
            final i = index ~/ 2;
            return ListTile(
              title: Text(
                snapshot.data[i]['title'],
              ),
            );
          }
      );
    }
    else {
      return Center(child: CircularProgressIndicator());
    }
  }

  Future<void> _pullRefresh() async {
    List<dynamic> freshData = await fetchFeed();
    setState(() {
      data = Future.value(freshData);
    });
  }

  Future<List<dynamic>> fetchFeed() async {
    final String apiUrl = "https://jsonplaceholder.typicode.com/posts";
    var result = await http.get(Uri.parse(apiUrl));
    return json.decode(result.body);
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
          style: TextStyle(fontSize: 24.0)
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
          style: TextStyle(fontSize: 24.0)
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
          style: TextStyle(fontSize: 24.0)
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
                  leading: Icon(
                    Icons.star_outline,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  onTap: () => {Navigator.of(context).pop()},
                ),
                ListTile(
                  title: Text('Настройки'),
                  leading: Icon(
                    Icons.settings_outlined,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  onTap: () => {Navigator.of(context).pop()},
                ),
                ListTile(
                  title: Text('Помощь'),
                  leading: Icon(
                    Icons.help_outline,
                    color: Theme.of(context).iconTheme.color,
                  ),
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
                      leading: Icon(
                        Icons.logout,
                        color: Theme.of(context).iconTheme.color,
                      ),
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
