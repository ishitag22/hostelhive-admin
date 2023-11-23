import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ThemeModal.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings", style: TextStyle(color: Colors.black),),
        elevation: 0,
        backgroundColor: Colors.amberAccent,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Settings(),
      ),
    );
  }
}

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool dark = false;

  //bool per = true;
  bool noti = false;

  final MaterialStateProperty<Color?> trackColor = MaterialStateProperty
      .resolveWith<Color?>(
        (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return Colors.amber;
      }
      return null;
    },
  );

  final MaterialStateProperty<Color?> overlayColor = MaterialStateProperty
      .resolveWith<Color?>(
        (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return Colors.amber.withOpacity(0.54);
      }
      if (states.contains(MaterialState.disabled)) {
        return Colors.grey.shade400;
      }
      return null;
    },
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildDarkModeSwitchRow("Dark Mode", dark),
        //buildSwitchRow("Permissions", per),
        buildPushNotificationsSwitchRow("Push Notifications", noti),
      ],
    );
  }

  Widget buildDarkModeSwitchRow(String text, bool value) {
    return Consumer(builder: (context, ThemeModal themeNotifier, child) {
      return Card(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        borderOnForeground: true,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.amber),
            borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(text,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      fontSize: 17)),
              Switch(
                value: themeNotifier.isDark ? true: false,
                overlayColor: overlayColor,
                trackColor: trackColor,
                thumbColor: MaterialStateProperty.all(Colors.black),
                onChanged: (bool newValue) {
                  themeNotifier.isDark
                      ? themeNotifier.isDark= false
                      : themeNotifier.isDark= true;
                  setState(() {
                    if (text == "Dark Mode") {
                      dark = newValue;
                    }
                  });
                },
              ),
            ],
          ),
        ),
      );
    }
    );
  }

  Widget buildPushNotificationsSwitchRow(String text, bool value) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      borderOnForeground: true,
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.amber),
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                text,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    fontSize: 17)
            ),
            Switch(
              value: value,
              overlayColor: overlayColor,
              trackColor: trackColor,
              thumbColor: MaterialStateProperty.all(Colors.black),
              onChanged: (bool newValue) {
                setState(() {
                  if (text == "Push Notifications") {
                    noti = newValue;
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
