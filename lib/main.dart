import 'dart:math';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:productivity_timer/settings.dart';
import 'package:productivity_timer/timermodel.dart';
import './timer.dart';

class ProductivityButton extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final VoidCallback onPressed;

  const ProductivityButton({
    super.key,
    required this.color,
    required this.text,
    required this.size,
    required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: color,
      minWidth: size,
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final double defaultPadding = 5.0;
  final double buttonSize = 16.0;
  final CountDownTimer timer = CountDownTimer();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    timer.startWork();
    final List<PopupMenuItem<String>> menuItems = <PopupMenuItem<String>>[];
    menuItems.add(
      PopupMenuItem(
        value: 'Settings',
        child: Text('Settings'),
      ),
    );
    BuildContext ctx = context;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Work Timer',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('Work Timer'),
          ),
          actions: [
            PopupMenuButton<String>(
              itemBuilder: (context) => menuItems.toList(),
              onSelected: (s) {
                if (s == 'Settings') {
                  Navigator.of(ctx).push(MaterialPageRoute(
                      builder: (context) => SettingsScreen()));
                }
              },
            ),
          ],
        ),
        body: LayoutBuilder(builder: (context, constraints) {
          final double availableWidth = constraints.maxWidth;
          final double availableHeight = constraints.maxHeight;
          return Column(
            children: [
              ElevatedButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SettingsScreen())),
                  child: Text("Settings")),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                  Expanded(
                    child: ProductivityButton(
                        color: Color(0xff009688),
                        text: "Work",
                        size: buttonSize,
                        onPressed: () => timer.startWork()),
                  ),
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                  Expanded(
                    child: ProductivityButton(
                        color: Color(0xff607D8B),
                        text: "Short Break",
                        size: buttonSize,
                        onPressed: () => timer.startBreak(true)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                  Expanded(
                    child: ProductivityButton(
                        color: Color(0xff455A64),
                        text: "Long Break",
                        size: buttonSize,
                        onPressed: () => timer.startBreak(false)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                ],
              ),
              Expanded(
                child: StreamBuilder(
                  initialData: '00:00',
                  stream: timer.stream(),
                  builder: (context, snapshot) {
                    TimerModel timer = (snapshot.data == '00:00')
                        ? TimerModel('00:00', 1)
                        : snapshot.data as TimerModel;
                    return CircularPercentIndicator(
                      radius: min(availableHeight / 1.2, availableWidth) / 2.2,
                      lineWidth: 10.0,
                      percent: timer.percent,
                      center: Text(timer.time,
                          style: (availableWidth > 350)
                              ? Theme.of(context).textTheme.displayLarge
                              : (availableWidth > 150)
                                  ? Theme.of(context).textTheme.displayMedium
                                  : Theme.of(context).textTheme.displaySmall),
                      progressColor: Color.fromARGB(255, 32, 138, 186),
                    );
                  },
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                  Expanded(
                    child: ProductivityButton(
                      color: Color(0xff212121),
                      text: 'Stop',
                      size: buttonSize,
                      onPressed: () => timer.stopTimer(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                  Expanded(
                      child: ProductivityButton(
                          color: Color(0xff009688),
                          text: 'Restart',
                          size: buttonSize,
                          onPressed: () => timer.startTimer())),
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}

void goToSettings(BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => SettingsScreen()));
}

void emptyMethod() {}

class TimerHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<PopupMenuItem<String>> menuItems = <PopupMenuItem<String>>[];
    menuItems.add(PopupMenuItem(
      value: 'Settings',
      child: Text('Settings'),
    ));
    return Container();
  }
}
