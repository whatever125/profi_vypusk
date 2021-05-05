import 'package:flutter/material.dart';

class SearchTab extends StatelessWidget {
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
