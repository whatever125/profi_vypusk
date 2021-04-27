import 'package:flutter/material.dart';
import 'dart:math';


void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PROFIВЫБОР',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: Feed(),
      routes: <String, WidgetBuilder> {
        Search.routeName : (BuildContext context) => Search(),
        Favorite.routeName : (BuildContext context) => Favorite()
      }
    );
  }
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
      appBar: AppBar(
        title: Text('Лента'),
      ),
      drawer: NavDrawer(),
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
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Поиск работы'),
      ),
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
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Избранное'),
      ),
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
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Профиль'),
      ),
      body: Center(
        child: Text(
            'Profile',
            style: TextStyle(
                fontSize: 24.0
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
                      backgroundColor: Colors.blue,
                      child: Text('ИИ')
                  ),
                ),
                ListTile(
                  title: Text('Лента'),
                  leading: Icon(Icons.today),
                  onTap: () => {
                    Navigator.of(context).push(
                        PageRouteBuilder(
                            pageBuilder: (BuildContext context, _, __) => Feed()
                        )
                    )
                  },
                ),
                ListTile(
                  title: Text('Поиск работы'),
                  leading: Icon(Icons.search),
                  onTap: () => {
                    Navigator.of(context).push(
                        PageRouteBuilder(
                            pageBuilder: (BuildContext context, _, __) => Search()
                        )
                    )
                  },
                ),
                ListTile(
                  title: Text('Избранное'),
                  leading: Icon(Icons.star_outline),
                  onTap: () => {
                    Navigator.of(context).push(
                        PageRouteBuilder(
                            pageBuilder: (BuildContext context, _, __) => Favorite()
                        )
                    )
                  },
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
                            title: Text('Помощь'),
                            leading: Icon(Icons.help_outline),
                            onTap: () => {Navigator.of(context).pop()},
                          ),
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
