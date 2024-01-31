import 'package:flutter/material.dart';

class MyTextButton extends StatelessWidget {
  final String text;
  final Function() onPressed;

  const MyTextButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ));
    // return TextButton(
    //   style: TextButton.styleFrom(
    //     padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 13.0),
    //     elevation: 2.0,
    //     primary: kTextColor,
    //     textStyle: const TextStyle(
    //       fontSize: 16.0,
    //       fontFamily: 'Paytone',
    //     ),
    //   ),
    //   child: Text(text),
    //   onPressed: onPressed,
    // );
  }
}
