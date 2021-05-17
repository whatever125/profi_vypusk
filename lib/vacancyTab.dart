import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VacancyTab extends StatefulWidget {
  @override
  VacancyTabState createState() => VacancyTabState();
}

class VacancyTabState extends State<VacancyTab> {
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
