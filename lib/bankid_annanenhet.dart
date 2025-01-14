import 'package:flutter/material.dart';

class BankidAnnanenhet extends StatelessWidget {
  const BankidAnnanenhet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bank-ID på denna enhet', style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
        backgroundColor: const Color.fromARGB(255, 6, 63, 121),
      ),
      body: const Center(
        child: Text(
          'Här kan du logga in med Bank-ID på denna enhet.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
