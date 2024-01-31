import 'package:flutter/material.dart';
import 'package:tic_tac_toe_release/constants.dart';

class MaterialButtonWidget extends StatelessWidget {
  final String text;
  final double textSize;
  final textPadding;
  final Function() onPressed;

  MaterialButtonWidget(
      {required this.text,
      required this.textSize,
      this.textPadding,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: screenHeight * 0.01322, horizontal: screenWidth * 0.08333),
      child: MaterialButton(
        padding: EdgeInsets.all(textPadding ?? 8.0),
        textColor: kTextColor,
        color: kContainerCardColor,
        minWidth: double.infinity,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Text(
          text,
          style: TextStyle(fontFamily: 'Paytone', fontSize: textSize),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
