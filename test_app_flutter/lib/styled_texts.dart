import 'package:flutter/material.dart';

class RegularText extends StatelessWidget {
  const RegularText(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: const TextStyle(color: Colors.white, fontSize: 18));
  }
}
