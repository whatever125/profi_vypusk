import 'package:flutter/material.dart';
import 'package:profi_vypusk/ui/pages/homePage/homePage.dart';
import 'package:profi_vypusk/ui/themes/theme.dart';
import 'package:profi_vypusk/ui/themes/colors.dart';
import 'package:provider/provider.dart';
import 'custom_checkbox.dart';
class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}
enum Language { russian, english }

class _SettingsPageState extends State<SettingsPage> {

  Language _language = Language.russian;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Настройки"),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Consumer<AppTheme>(
            builder: (context, theme, child) => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[Padding(
                child: Align(
                    alignment: Alignment.bottomLeft,
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 20,
                          color: theme.getTheme() == AppTheme.darkTheme
                              ? DarkColor.text
                              : LightColor.text,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Основные настройки',)
                        ],
                      ),
                    )),
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
              ),
              Padding(child: Row(children: [Expanded(child: Text("Настройка 1")), CustomCheckbox(isChecked: false, selectedColor:Theme.of(context).accentColor)]),
              padding: EdgeInsets.symmetric(vertical: 10),),
              Padding(child: Row(children: [Expanded(child: Text("Настройка 2")), CustomCheckbox(isChecked: false, selectedColor:Theme.of(context).accentColor)]),
              padding: EdgeInsets.symmetric(vertical: 10),),
                Padding(
                  child: Align(
                      alignment: Alignment.bottomLeft,
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 20,
                            color: theme.getTheme() == AppTheme.darkTheme
                                ? DarkColor.text
                                : LightColor.text,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Язык',)
                          ],
                        ),
                      )),
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                ),
                RadioListTile<Language>(
                  title: const Text('Русский'),
                  value: Language.russian,
                  groupValue: _language,
                  onChanged: (Language value) {setState(() {_language = value;});},
                ),
                RadioListTile<Language>(
                  title: const Text('English'),
                  value: Language.english,
                  groupValue: _language,
                  onChanged: (Language value) {setState(() {_language = value;});},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}