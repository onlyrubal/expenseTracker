import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveButton extends StatelessWidget {
  final String buttonText;
  final Function datePickerHandler;

  AdaptiveButton({
    this.buttonText,
    this.datePickerHandler,
  });
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(
              buttonText,
            ),
            padding: EdgeInsets.all(0),
            onPressed: datePickerHandler,
          )
        : FlatButton(
            onPressed: datePickerHandler,
            padding: EdgeInsets.all(10),
            child: Text(
              buttonText,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            textColor: Color(0xff4c4c4c),
          );
  }
}
