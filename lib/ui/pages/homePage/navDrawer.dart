import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:profi_vypusk/ui/pages/welcomePage.dart';
import 'package:profi_vypusk/ui/themes/theme.dart';
import 'package:provider/provider.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 6,
                  child: RichText(
                    text: TextSpan(
                      style: Theme.of(context)
                          .textTheme
                          .button
                          .copyWith(fontSize: 24),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'PROFIВЫПУСК',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
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
          ),
          Divider(),
          Expanded(
            child: ListView(
              children: <Widget>[
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
                      onTap: () => {
                        Navigator.pushAndRemoveUntil(
                          context,
                          PageTransition(
                            type: PageTransitionType.fade,
                            child: WelcomePage(),
                          ),
                          (route) => route.isFirst,
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
