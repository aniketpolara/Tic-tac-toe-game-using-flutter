import 'package:flutter/material.dart';
import 'package:tic_tac_toe_release/constants.dart';
import 'package:tic_tac_toe_release/models/responsive_ui.dart';
import 'package:tic_tac_toe_release/models/settings.dart';
import 'package:tic_tac_toe_release/screens/welcome/components/alert_dialog.dart';
import 'package:tic_tac_toe_release/screens/welcome/components/scaffold_body.dart';
import 'package:tic_tac_toe_release/utilities/audio_player.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    if (Settings.audioValues[1]) AudioPlayer.playMusic();
  }

  @override
  Widget build(BuildContext context) {
    ResponsiveUI.getDeviceHeight(context);
    ResponsiveUI.getDeviceWidth(context);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: _buildAppBar(context),
      body: MyScaffoldBody(),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: kBackgroundColor,
      title: Text(
        'TIC TAC TOE',
        textAlign: TextAlign.center,
        style: kTextStyle.copyWith(
          fontSize: ResponsiveUI.getFontSize(33.0),
        ),
      ),
      leading: IconButton(
        color: kTextColor,
        iconSize: ResponsiveUI.getFontSize(35.0),
        padding: const EdgeInsets.all(0.0),
        onPressed: () => MyAlertDialog.buildAlert(context),
        icon: const Icon(Icons.menu),
      ),
    );
  }
}
