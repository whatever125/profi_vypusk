import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:profi_vypusk/ui/themes/theme.dart';
import 'package:profi_vypusk/ui/themes/colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
                    ),
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
