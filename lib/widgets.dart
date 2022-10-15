import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class SettingsButton extends StatelessWidget {
  final Color color;
  final String text;
  final int value;
  SettingsButton(this.color, this.text, this.value);
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(this.text, style: TextStyle(color: Colors.white)),
      onPressed: () => null,
      color: this.color,
    );
  }
}
