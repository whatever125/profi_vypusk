import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'welcomePage.dart';
import 'package:profi_vypusk/theme.dart';
import 'package:profi_vypusk/colors.dart';
import 'package:provider/provider.dart';

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
          page: ProfileTab(),
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
        },
      ),
    );
  }

  Widget _listView(AsyncSnapshot snapshot) {
    if (snapshot.hasData) {
      return ListView.builder(
        shrinkWrap: false,
        padding: EdgeInsets.all(15.0),
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) {
          if (index.isOdd) return Divider();
          final i = index ~/ 2;
          return ListTile(
            title: Text(
              snapshot.data[i]['title'],
            ),
          );
        },
      );
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

class ProfileTab extends StatefulWidget {
  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  Future<List<dynamic>> user;

  @override
  void initState() {
    super.initState();
    user = _fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildProfile(),
    );
  }

  Widget _buildProfile() {
    return Container(
      child: FutureBuilder<List<dynamic>>(
        future: user,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return RefreshIndicator(
            child: Stack(
              children: [
                ListView(),
                _profileView(snapshot),
              ],
            ),
            onRefresh: _pullRefresh,
          );
        },
      ),
    );
  }

  Widget _profileView(AsyncSnapshot snapshot) {
    if (snapshot.hasData) {
      return SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Container(
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(
                          "https://thispersondoesnotexist.com/image",
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Container(
                        height: 80,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Consumer<AppTheme>(
                              builder: (context, theme, child) => RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 25,
                                    color:
                                        theme.getTheme() == AppTheme.darkTheme
                                            ? DarkColor.text
                                            : LightColor.text,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: snapshot.data[0]['name'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Consumer<AppTheme>(
                              builder: (context, theme, child) => Text(
                                snapshot.data[0]['email'],
                                style: TextStyle(
                                  fontSize: 15,
                                  color: theme.getTheme() == AppTheme.darkTheme
                                      ? DarkColor.secondary
                                      : LightColor.secondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Divider(),
              SizedBox(
                height: 15,
              ),
              TextButton(
                child: Container(
                  height: 40,
                  child: Row(
                    children: [
                      Icon(Icons.person_pin),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Личные данные',
                        style: Theme.of(context)
                            .textTheme
                            .button
                            .copyWith(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                onPressed: () => {},
              ),
              TextButton(
                child: Container(
                  height: 40,
                  child: Row(
                    children: [
                      Icon(Icons.dashboard),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Портфолио',
                        style: Theme.of(context)
                            .textTheme
                            .button
                            .copyWith(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                onPressed: () => {},
              ),
              TextButton(
                child: Container(
                  height: 40,
                  child: Row(
                    children: [
                      Icon(Icons.text_snippet),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Резюме',
                        style: Theme.of(context)
                            .textTheme
                            .button
                            .copyWith(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                onPressed: () => {},
              ),
            ],
          ),
        ),
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }

  Future<void> _pullRefresh() async {
    List<dynamic> freshData = await _fetchProfile();
    setState(() {
      user = Future.value(freshData);
    });
  }

  Future<List<dynamic>> _fetchProfile() async {
    final apiUrl = "https://60911f0c50c2550017677a1b.mockapi.io/users";
    var result = await http.get(Uri.parse(apiUrl));
    return json.decode(result.body);
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
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 7,
                        child: UserAccountsDrawerHeader(
                          accountName: Text('Иванов Иван'),
                          accountEmail: Text('ivanov@ivan.org'),
                          currentAccountPicture: CircleAvatar(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue,
                            child: Text('ИИ'),
                          ),
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
                            alignment: Alignment.topCenter,
                          ),
                        ),
                      ),
                    ],
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
                      onTap: () => {
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst),
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => WelcomePage()),
                          ),
                        ),
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
