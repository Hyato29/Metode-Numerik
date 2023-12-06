import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextInputWidget extends StatelessWidget {
  TextInputWidget({required this.title, required this.controller, super.key});

  String title;
  double value = 0;
  TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 50,
        child: TextField(
            keyboardType: TextInputType.number,
            controller: controller,
            decoration: InputDecoration(
                hintStyle: const TextStyle(
                    fontFamily: "Poppins", color: Color(0xFF535050)),
                hintText: title,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xFF959191))),
                border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xFF959191)),
                    borderRadius: BorderRadius.circular(10)),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 17))),
      ),
    );
  }
}
