import 'package:flutter/material.dart';

import '../connections/ssh.dart';

class Const {
  static SSH ssh = SSH();
  static String servicePort = "3000";
  
  static Color grey = const Color(0xFF2d2d2d);
  static Color darkGrey = const Color(0xFF222222);
  static Color lightGrey = const Color(0xFF424242);
  static Color superlightGrey = const Color(0xFFA1A3A5);
  static Color foregroundColor = const Color(0xCD144ED3);

  static TextStyle simpleText = const TextStyle(
    color: Colors.white,
    fontSize: 20,
  );

  static TextStyle titleText = const TextStyle(
    color: Colors.white,
    fontSize: 20,
  );

  static TextStyle BigText = const TextStyle(
    color: Colors.white,
    fontSize: 20,
  );

  static TextStyle splashTitleText = TextStyle(
    color: superlightGrey,
    fontSize: 50,
  );
}