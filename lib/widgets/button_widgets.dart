import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ButtonWidget extends StatelessWidget {
  ButtonWidget({required this.title, required this.color, super.key});

  String title;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 50,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.white, fontFamily: 'Poppins', fontSize: 16),
        ),
      ),
    );
  }
}
