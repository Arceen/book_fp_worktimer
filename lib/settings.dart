import 'package:flutter/material.dart';
import 'package:productivity_timer/widgets.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Settings(),
    );
  }
}

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  static const String WORKTIME = "workTime";
  static const String SHORTBREAK = "shortBreak";
  static const String LONGBREAK = "longBreak";
  TextEditingController? txtWork;
  TextEditingController? txtShort;
  TextEditingController? txtLong;
  @override
  void initState() {
    txtWork = TextEditingController();
    txtShort = TextEditingController();
    txtLong = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(fontSize: 24);
    return Container(
      child: GridView.count(
        scrollDirection: Axis.vertical,
        crossAxisCount: 3,
        childAspectRatio: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: <Widget>[
          Text("Work", style: textStyle),
          Text(""),
          Text(""),
          SettingsButton(Color(0xff455A64), "-", -1),
          TextField(
              style: textStyle,
              controller: txtWork,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number),
          SettingsButton(
            Color(0xff009688),
            "+",
            1,
          ),
          Text("Short", style: textStyle),
          Text(""),
          Text(""),
          SettingsButton(
            Color(0xff455A64),
            "-",
            -1,
          ),
          TextField(
              style: textStyle,
              controller: txtShort,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number),
          SettingsButton(Color(0xff009688), "+", 1),
          Text(
            "Long",
            style: textStyle,
          ),
          Text(""),
          Text(""),
          SettingsButton(
            Color(0xff455A64),
            "-",
            -1,
          ),
          TextField(
              style: textStyle,
              controller: txtLong,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number),
          SettingsButton(
            Color(0xff009688),
            "+",
            1,
          ),
        ],
        padding: const EdgeInsets.all(20.0),
      ),
    );
  }
}
