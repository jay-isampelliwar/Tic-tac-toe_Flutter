import 'package:flutter/material.dart';

class Undo extends StatelessWidget {
  bool isLightMode;
  Undo({required this.isLightMode});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Icon(
          Icons.undo_rounded,
          size: 30,
          color: isLightMode ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
