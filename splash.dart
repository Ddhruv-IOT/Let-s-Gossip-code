import 'home.dart';
import 'package:flutter/material.dart';
import 'package:custom_splash/custom_splash.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomSplash(
      imagePath: 'assets/splash.gif',
      backGroundColor: Colors.purple[900],
      animationEffect: 'top-down',
      logoSize: 500,
      home: Myhome(),
      duration: 2500,
      type: CustomSplashType.StaticDuration,
    );
  }
}
