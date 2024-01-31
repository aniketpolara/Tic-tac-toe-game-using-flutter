import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tic_tac_toe_release/models/audio_resume.dart';
import 'package:tic_tac_toe_release/utilities/splash_screen.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UnityAds.init(
    gameId: '5289380',
    onComplete: ()  => print('Initialization Complete'),
    onFailed: (error, message) =>
        print('Initialization Failed: $error $message'),
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
  WidgetsBinding.instance.addObserver(new Handler());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: SplashScreen(),
    );
  }
}
