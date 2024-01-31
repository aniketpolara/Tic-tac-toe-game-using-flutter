import 'package:flutter/material.dart';
import 'package:tic_tac_toe_release/ads/unity_ads_demo.dart';
import 'package:tic_tac_toe_release/constants.dart';
import 'package:tic_tac_toe_release/models/responsive_ui.dart';
import 'package:tic_tac_toe_release/screens/pickup/pickup_screen.dart';
import 'package:tic_tac_toe_release/widgets/material_button.dart';

class MyScaffoldBody extends StatefulWidget {
  @override
  State<MyScaffoldBody> createState() => _MyScaffoldBodyState();
}

class _MyScaffoldBodyState extends State<MyScaffoldBody> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await AdManager.loadUnityIntAd();
      await AdManager.loadUnityRewardedAd();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(child: _buildRichText(context)),
          MaterialButtonWidget(
              text: 'Pick a side',
              textSize: ResponsiveUI.getFontSize(35.0),
              textPadding: 12.0,
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PickUpScreen()),
                );
                await AdManager.showIntAd();
              })
        ],
      ),
    );
  }

  Widget _buildRichText(BuildContext context) {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            _buildTextSpan(context, 'X', kXTextStyle),
            _buildTextSpan(context, 'O', kOTextStyle),
          ],
        ),
      ),
    );
  }

  TextSpan _buildTextSpan(
      BuildContext context, String letter, TextStyle textStyle) {
    return TextSpan(
      text: letter,
      style: textStyle.copyWith(
        fontSize: ResponsiveUI.getFontSize(200.0),
      ),
    );
  }
}
