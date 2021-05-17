import 'package:flutter/material.dart';
import 'package:profi_vypusk/ui/pages/homePage/homePage.dart';
import 'package:profi_vypusk/ui/themes/theme.dart';
import 'package:profi_vypusk/ui/themes/colors.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowGlow();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: FlutterLogo(),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Consumer<AppTheme>(
              builder: (context, theme, child) => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    child: Align(
                        alignment: Alignment.bottomLeft,
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 25,
                              color: theme.getTheme() == AppTheme.darkTheme
                                  ? DarkColor.text
                                  : LightColor.text,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Добро пожаловать',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          ),
                        )),
                    padding: const EdgeInsets.symmetric(
                      vertical: 25,
                    ),
                  ),
                  Theme(
                    data: Theme.of(context).copyWith(
                        primaryColor: theme.getTheme() == AppTheme.darkTheme
                            ? DarkColor.accent
                            : LightColor.accent),
                    child: Padding(
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                    ),
                  ),
                  Theme(
                    data: Theme.of(context).copyWith(
                        primaryColor: theme.getTheme() == AppTheme.darkTheme
                            ? DarkColor.accent
                            : LightColor.accent),
                    child: Padding(
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Пароль',
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                    ),
                  ),
                  Padding(
                    child: Align(
                      child: TextButton(
                        child: Text(
                          'Забыли пароль?',
                          style: TextStyle(
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        onPressed: () => {},
                      ),
                      alignment: Alignment.topRight,
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 0,
                    ),
                  ),
                  Padding(
                    child: Container(
                      height: 50,
                      width: 125,
                      decoration: BoxDecoration(
                          color: Color(0xFF1DA1F2),
                          borderRadius: BorderRadius.circular(25)),
                      child: TextButton(
                        child: Text(
                          'Войти',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () => {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                            (route) => route.isFirst,
                          ),
                        },
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
