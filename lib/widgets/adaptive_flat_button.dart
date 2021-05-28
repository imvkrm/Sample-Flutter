import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final Function showDatePicker;
  final String label;

  AdaptiveFlatButton(this.showDatePicker, this.label);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: ()=>showDatePicker())
        : TextButton(
            onPressed:()=> showDatePicker(),
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          );
  }
}
