import 'package:flutter/material.dart';
import 'package:profi_vypusk/ui/themes/theme.dart';
import 'package:profi_vypusk/ui/themes/colors.dart';
import 'package:profi_vypusk/ui/pages/signinPage.dart';
import 'package:profi_vypusk/ui/pages/signUpPage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20),
              FlutterLogo(),
              Spacer(),
              Consumer<AppTheme>(
                builder: (context, theme, child) => Padding(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 30,
                        color: theme.getTheme() == AppTheme.darkTheme
                            ? DarkColor.text
                            : LightColor.text,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Работа найдется для каждого',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                child: Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                    color: Color(0xFF1DA1F2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: TextButton(
                    child: Text(
                      'Зарегистрироваться',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () => {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: SignUpPage(),
                        ),
                      ),
                    },
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                ),
              ),
              Spacer(),
              Padding(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Уже есть учетная запись?',
                      style: TextStyle(
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                    TextButton(
                      child: Text(
                        'Войти',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      onPressed: () => {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.fade,
                            child: SignInPage(),
                          ),
                        ),
                      },
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
