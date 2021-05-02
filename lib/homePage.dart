import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'welcomePage.dart';
import 'package:profi_vypusk/theme.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            }));
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
          });
    } else {
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
        child: Text('Search', style: TextStyle(fontSize: 24.0)),
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
        child: Text('Favorites', style: TextStyle(fontSize: 24.0)),
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
        child: Text('Profile', style: TextStyle(fontSize: 24.0)),
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
              child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Row(children: <Widget>[
                  Expanded(
                    flex: 7,
                    child: UserAccountsDrawerHeader(
                      accountName: Text('Иванов Иван'),
                      accountEmail: Text('ivanov@ivan.org'),
                      currentAccountPicture: CircleAvatar(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue,
                          child: Text('ИИ')),
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Consumer<AppTheme>(
                          builder: (context, theme, child) => IconButton(
                              icon: Icon(Icons.lightbulb_outline),
                              color: Theme.of(context).accentColor,
                              onPressed: () {
                                theme.changeMode();
                              },
                              alignment: Alignment.topCenter))),
                ]),
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
          )),
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
                        onTap: () => {
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst),
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => WelcomePage()))),
                        },
                      ),
                    ],
                  ))))
        ],
      ),
    );
  }
}
