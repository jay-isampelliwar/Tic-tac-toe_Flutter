import 'package:flutter/material.dart';

import '../constant/app_constants.dart';

class PlayerOne extends StatelessWidget {
  bool isLightMode;
  PlayerOne({required this.isLightMode});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isLightMode ? lightPrimary : darkPrimary,
          boxShadow: [
            BoxShadow(
                offset: const Offset(-3, -3),
                color: isLightMode ? lightTopShadow : darkTopShadow,
                blurRadius: 3,
                spreadRadius: 1),
            BoxShadow(
                offset: const Offset(3, 3),
                color: isLightMode ? lightBottomShadow : darkBottomShadow,
                blurRadius: 3,
                spreadRadius: 1),
          ],
        ),
        child: const Center(
          child: Text(
            "X",
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 78,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
