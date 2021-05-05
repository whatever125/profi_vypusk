import 'package:flutter/material.dart';
import 'package:profi_vypusk/ui/pages/welcomePage.dart';
import 'package:profi_vypusk/ui/themes/theme.dart';
import 'package:provider/provider.dart';

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
