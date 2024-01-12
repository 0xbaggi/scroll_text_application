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
          Text("Flutter Scrolling Text for Liquid Galaxy", style: Const.splashTitleText),
          const SizedBox(height: 60),
          Text("made by Baggini Mattia", style: Const.splashSimpleText),
          const SizedBox(height: 10),
          Text("KISS APP Competition 2024 | www.liquidgalaxy.eu", style: Const.splashSimpleText),
          const Spacer(),
          LinearProgressIndicator(color: Const.darkGrey),
        ])),
    );
  }
}
