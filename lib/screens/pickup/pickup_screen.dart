import 'package:flutter/material.dart';
import 'package:tic_tac_toe_release/ads/unity_ads_demo.dart';
import 'package:tic_tac_toe_release/constants.dart';
import 'package:tic_tac_toe_release/models/player.dart';
import 'package:tic_tac_toe_release/models/responsive_ui.dart';
import 'package:tic_tac_toe_release/screens/game/game_screen.dart';
import 'package:tic_tac_toe_release/screens/pickup/gesture_detector.dart';
import 'package:tic_tac_toe_release/widgets/material_button.dart';

class PickUpScreen extends StatefulWidget {
  @override
  _PickUpScreenState createState() => _PickUpScreenState();
}

class _PickUpScreenState extends State<PickUpScreen> {
  @override
  void initState() {
    Player.pressed = '';
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await AdManager.loadUnityIntAd();
      await AdManager.loadUnityRewardedAd();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kBackgroundColor,
        elevation: 0,
        title: Text(
          'Choose a side',
          textAlign: TextAlign.center,
          style: kTextStyle.copyWith(fontSize: ResponsiveUI.getFontSize(30.0)),
        ),
      ),
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MyGestureDetector(
              onTapFunction: () => setState(() => Player.pressed = Player.X),
              containerColor: Player.pressed == Player.X
                  ? kContainerCardColor
                  : kBackgroundColor,
              text: "X",
            ),
            MyGestureDetector(
              onTapFunction: () => setState(() => Player.pressed = Player.O),
              containerColor: Player.pressed == Player.O
                  ? kContainerCardColor
                  : kBackgroundColor,
              text: "O",
            ),
            MaterialButtonWidget(
                text: 'Start',
                textSize: ResponsiveUI.getFontSize(screenWidth * 0.08333),
                onPressed: () async {
                  await AdManager.showIntAd();
                  // ignore: use_build_context_synchronously
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => GameScreen()));
                })
          ],
        ),
      ),
    );
  }
}
