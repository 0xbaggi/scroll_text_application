import 'package:flutter/material.dart';

import '../constants/constants.dart';

class BigButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String text;

  const BigButton({
    Key? key,
    required this.onPressed,
    required this.icon, required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: 280,
      height: 280,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            elevation: 0,
            padding: const EdgeInsets.all(20),
            backgroundColor: Const.darkGrey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                color: Const.lightGrey,
                width: 4,
                style: BorderStyle.solid,
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon,
                  size: 80.0, color: Colors.white),
              Text(text, style: Const.BigText)
            ],
          )
      ),
    );
  }
}