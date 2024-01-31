import 'package:flutter/material.dart';
import 'package:tic_tac_toe_release/constants.dart';
import 'package:tic_tac_toe_release/models/player.dart';
import 'package:tic_tac_toe_release/screens/game/components/score_container.dart';

import '../../../models/settings.dart';

class MyProfileContainer extends StatelessWidget {
  final String symbol;
  final Color cardColor;
  final int playerIndex;

  const MyProfileContainer(
      {super.key,
      required this.playerIndex,
      required this.symbol,
      required this.cardColor});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(10.0),
            border:
                cardColor == kActiveCardColor || cardColor == kWinnerCardColor
                    ? Border.all(color: Colors.white)
                    : null,
          ),
          constraints: BoxConstraints.tightFor(
            width: screenWidth * 0.3055,
            height: screenHeight * 0.1785,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.022,
                    vertical: screenHeight * 0.005),
                child: Text(Settings.playerNames[playerIndex],
                    style: kTextStyle.copyWith(fontSize: 15.0)),
              ),
              Image.asset(
                'assets/images/avatar-${Settings.playerAvatars[playerIndex]}.png',
                width: screenWidth * 0.125,
              ),
              Text(
                symbol,
                style: kTextStyle.copyWith(
                  color: symbol == 'X' ? kXColor : kOColor,
                  fontFamily: symbol == 'X' ? 'Carter' : 'Paytone',
                  fontSize: screenWidth * 0.08333,
                ),
              ),
            ],
          ),
        ),
        MyScoreContainer('${Player.playerScores[playerIndex]}'),
      ],
    );
  }
}
