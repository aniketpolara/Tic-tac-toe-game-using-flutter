import 'package:flutter/material.dart';
import 'package:tic_tac_toe_release/constants.dart';
import 'package:tic_tac_toe_release/models/responsive_ui.dart';

class MyGestureDetector extends StatelessWidget {
  final Color containerColor;
  final String text;
  final Function() onTapFunction;

  const MyGestureDetector(
      {required this.onTapFunction,
      required this.containerColor,
      required this.text});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Expanded(
      child: GestureDetector(
        onTap: onTapFunction,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenHeight * 0.03655,
              vertical: screenWidth * 0.02645),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              color: containerColor,
              borderRadius: BorderRadius.circular(28.0),
            ),
            child: _buildContainerText(context),
          ),
        ),
      ),
    );
  }

  Widget _buildContainerText(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: text == 'X'
            ? kXTextStyle.copyWith(fontSize: ResponsiveUI.getFontSize(170.0))
            : kOTextStyle.copyWith(
                fontSize: ResponsiveUI.getFontSize(170.0),
              ),
      ),
    );
  }
}
