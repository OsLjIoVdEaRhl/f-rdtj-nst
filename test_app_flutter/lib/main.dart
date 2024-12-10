import 'package:flutter/material.dart';
import 'package:test_app_flutter/styled_texts.dart';

void main() {
  runApp(const MaterialApp(home: Sandbox()));
}

class Sandbox extends StatelessWidget {
  const Sandbox({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(title: const Text('sandbox'), backgroundColor: Colors.grey),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                height: 100,
                color: Colors.red,
                child: const RegularText('one')),
            Container(
                height: 200,
                color: Colors.blue,
                child: const RegularText('two')),
            Container(
                height: 300,
                color: Colors.green,
                child: const RegularText('three'))
          ],
        ));
  }
}
