import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:tic_tac_toe_release/constants.dart';


class MyAlert {
  static TextStyle textStyle = TextStyle(
    fontSize: 23.0,
    fontFamily: 'Paytone',
  );
  static AlertStyle alertStyle = AlertStyle(
    backgroundColor: kActiveCardColor,
    titleStyle: textStyle,
    alertPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
    alertBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  );

  static Future showAlert(BuildContext context, String msg, String emoji,
      String btnTitle, Function() nextRoundFunc) {
    return Alert(
        context: context,
        padding: const EdgeInsets.all(0.0),
        onWillPopActive: true,
        title: msg,
        style: alertStyle,
        closeIcon: const Icon(Icons.close),
        closeFunction: nextRoundFunc,
        content: Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Center(
              child: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text(emoji, style: TextStyle(fontSize: 50.0)),
          )),
        )),
        buttons: [
          DialogButton(
            child: Text(btnTitle, style: textStyle),
            onPressed: nextRoundFunc,
            color: kBackgroundColor,
          ),
        ]).show();
  }
}
