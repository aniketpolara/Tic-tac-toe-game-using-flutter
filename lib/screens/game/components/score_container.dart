import 'package:flutter/material.dart';
import 'package:tic_tac_toe_release/constants.dart';

class MyScoreContainer extends StatelessWidget {
  final String text;
  const MyScoreContainer(this.text);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(
          top: screenHeight * 0.0396,
          left: screenWidth * 0.02777,
          right: screenWidth * 0.0277),
      width: screenWidth * 0.1111,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: kContainerColor,
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: kTextStyle.copyWith(
          fontSize: screenWidth * 0.08333,
        ),
      ),
    );
  }
}
