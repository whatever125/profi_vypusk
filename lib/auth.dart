import 'package:flutter/material.dart';
import 'main.dart';

class AuthPage extends StatefulWidget {
  @override
  createState() => new AuthPageState();
}

class AuthPageState extends State<AuthPage> {
  String email = 'ivanov@ivan.org';
  String password = 'ivan2006';
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    Widget input(Icon icon, String hint, TextEditingController controller, bool obscureText) {
      return Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          style: TextStyle(fontSize: 20, color: Colors.white),
          decoration: InputDecoration(
            hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white30),
            hintText: hint,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 3)
            ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white54, width: 1)
              ),
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: IconTheme(
                data: IconThemeData(color: Colors.white),
                child: icon,
              ),
            )
          ),
        ),
      );
    }

    Widget button(String text, void func()) {
      return RaisedButton(
        splashColor: Theme.of(context).primaryColor,
        highlightColor: Theme.of(context).primaryColor,
        color: Colors.white,
        child: Text(
          text,
          style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor, fontSize: 20),
        ),
        onPressed: (){
          func();
        },
      );
    }

    Widget form(String label, void func()) {
      return Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 20, top: 100),
              child: input(Icon(Icons.email), "EMAIL", emailController, false),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: input(Icon(Icons.lock), "PASSWORD", passwordController, true),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20) ,
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: button(label, func)
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: <Widget>[
          form('LOGIN', (){})
        ],
      ),
    );
  }
}