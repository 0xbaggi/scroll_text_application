import 'dart:async';
import 'package:flutter/material.dart';
import '../constants/constants.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed('/home');
    });

    return Scaffold(
      backgroundColor: Const.darkGrey,
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          const Image(image: AssetImage('assets/lg_logo.png'), width: 500),
          const SizedBox(height: 50),
          Text("KISS APP Competition 2024", style: Const.splashTitleText),
          const SizedBox(height: 50),
          Text("made by Baggini Mattia", style: Const.simpleText),
          Text("https://www.liquidgalaxy.eu", style: Const.simpleText),
          const Spacer(),
          LinearProgressIndicator(color: Const.darkGrey),
        ])),
    );
  }
}
