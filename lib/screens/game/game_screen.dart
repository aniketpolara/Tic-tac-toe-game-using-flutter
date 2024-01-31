import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tic_tac_toe_release/ads/unity_ads_demo.dart';
import 'package:tic_tac_toe_release/constants.dart';
import 'package:tic_tac_toe_release/models/player.dart';
import 'package:tic_tac_toe_release/models/responsive_ui.dart';
import 'package:tic_tac_toe_release/models/settings.dart';
import 'package:tic_tac_toe_release/screens/game/components/alert_result.dart';
import 'package:tic_tac_toe_release/screens/game/components/card_gesture_detector.dart';
import 'package:tic_tac_toe_release/screens/game/components/profile_container.dart';
import 'package:tic_tac_toe_release/screens/game/components/result_container.dart';
import 'package:tic_tac_toe_release/screens/game/components/score_container.dart';
import 'package:tic_tac_toe_release/screens/game/components/text_button.dart';
import 'package:tic_tac_toe_release/screens/game/components/timer.dart';
import 'package:tic_tac_toe_release/utilities/audio_player.dart';

Player player = Player();

//5289380
class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  void initState() {
    super.initState();
    Player.resetStaticData();
    Player.resetData1();
    player.getPlayerSides();
    startTimer();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await AdManager.loadUnityIntAd();
      await AdManager.loadUnityRewardedAd();
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer!.cancel();
  }

  static const maxSeconds = 15;
  int seconds = maxSeconds;
  int pauseSeconds = 0;
  late Timer? timer;

  void resetTimer() => setState(() => seconds = maxSeconds);

  void stopTimer() => setState(() => timer!.cancel());

  void pauseTimer() => setState(() => pauseSeconds = seconds);

  void resumeTimer() => setState(() => seconds = pauseSeconds);

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (seconds > 0 && seconds < 16)
        setState(() => seconds--);
      else if (seconds == 0) {
        Player.player1 = !Player.player1;
        Player.changeProfileCardColor();
        resetTimer();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kBackgroundColor,
        actions: [
          MyTextButton(
            text: 'pause',
            onPressed: () {
              pauseTimer();
              stopTimer();
              MyAlert.showAlert(context, 'Game Paused!', '⏸', 'Resume', () {
                Navigator.pop(context);
                resumeTimer();
                startTimer();
              });
            },
          ),
          SizedBox(
              height: screenHeight * 0.1322,
              child: VerticalDivider(
                indent: 12,
                endIndent: 12,
                thickness: 1.5,
                color: Colors.white,
              )),
          MyTextButton(
            text: 'new',
            onPressed: () {
              resetTimer();
              Player.resetStaticData();
              Player.updatePlayer1();
            },
          ),
        ],
      ),
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: screenHeight * 0.016455,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                MyProfileContainer(
                    playerIndex: 0,
                    symbol: Player.p1,
                    cardColor: Player.cardColorP1),
                SizedBox(width: screenWidth * 0.02777),
                Column(
                  children: [
                    Visibility(
                      visible: !Player.completed,
                      child: MyCountDownTimer(
                          seconds: seconds, maxSeconds: maxSeconds),
                    ),
                    SizedBox(height: screenHeight * 0.06613),
                    Text('D',
                        style: kTextStyle.copyWith(
                            fontSize: screenWidth * 0.08333,
                            color: Colors.blue)),
                    MyScoreContainer('${Player.drawScore}'),
                  ],
                ),
                SizedBox(width: screenWidth * 0.02777),
                MyProfileContainer(
                    playerIndex: 1,
                    symbol: Player.p2,
                    cardColor: Player.cardColorP2),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.04629,
            ),
            Player.completed
                ? _buildResultContainer()
                : Expanded(child: _buildGameContainer(context)),
            Text(
              'TIC TAC TOE',
              textAlign: TextAlign.center,
              style: kTextStyle.copyWith(
                color: Colors.white54,
                fontSize: ResponsiveUI.getFontSize(50.0),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGameContainer(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(bottom: screenHeight * 0.0280),
      constraints: BoxConstraints.tightFor(
        width: ResponsiveUI.getWidth(context, 30.0),
        height: ResponsiveUI.getWidth(context, 30.0),
      ),
      decoration: BoxDecoration(
        color: kContainerColor,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Center(child: Wrap(children: _buildCardButtons())),
    );
  }

  MyResultContainer _buildResultContainer() {
    return MyResultContainer(
      player: player,
      onPressed: () {
        setState(() {
          resetTimer();
          startTimer();
          Player.resetStaticData();
          Player.resetData1();
          Player.changeProfileCardColor();
        });
      },
    );
  }

  List<CardGestureDetector> _buildCardButtons() {
    List<CardGestureDetector> buttons = [];
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        buttons.add(
          CardGestureDetector(
            onTapFunction: () => showPlayerSide(i, j),
            boxSide: Player.matrix[i][j],
            cardColor: Player.cardColors[i][j],
          ),
        );
      }
    }
    return buttons;
  }

  void showPlayerSide(int x, int y) {
    setState(() {
      if (Player.matrix[x][y] == '' && !Player.finished) {
        player.updateMatrix(x, y);
        if (Settings.audioValues[0]) AudioPlayer.playSound(Player.side);
        if (player.checkWinner(x, y)) {
          winnerLogic();
        } else if (Player.count == 9) {
          drawLogic();
        } else {
          Player.changeProfileCardColor();
          resetTimer();
        }
      }
    });
  }

  void winnerLogic() {
    stopTimer();
    Player.finished = true;
    player.changeWinnerCardColor();
    Future.delayed(Duration(milliseconds: 100),
        () => setState(() => player.updateCardColors()));
    Future.delayed(
      Duration(milliseconds: 800),
      () => setState(() {
        Player.winner = true;
        Player.updateScores();
        if (!Player.completed)
          MyAlert.showAlert(context, '${Player.getAlertTitle()}', '😎',
              'Next Round', nextRoundFunc);
        if (Settings.audioValues[0])
          AudioPlayer.playResultSound(Player.winnerPlayer);
      }),
    );
  }

  void drawLogic() {
    stopTimer();
    Future.delayed(
      Duration(milliseconds: 800),
      () => setState(() {
        Player.draw = true;
        Player.updateScores();
        if (!Player.completed)
          MyAlert.showAlert(context, '${Player.getAlertTitle()}', '😔',
              'Next Round', nextRoundFunc);
        if (Settings.audioValues[0])
          AudioPlayer.playResultSound(Player.winnerPlayer);
      }),
    );
  }

  void nextRoundFunc() {
    setState(() {
      AdManager.showRewardedAd();
      Player.resetStaticData();
      Player.changeProfileCardColor();
      resetTimer();
      startTimer();
      Navigator.pop(context);
    });
  }
}
