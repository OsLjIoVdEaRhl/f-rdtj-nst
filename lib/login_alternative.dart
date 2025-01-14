import 'package:flutter/material.dart';
import 'package:fardtjanst/bankid_annanenhet.dart';
import 'package:fardtjanst/personlig_kod.dart';

class LoginAlternative extends StatelessWidget {
  const LoginAlternative({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            Image.asset(
              'assets/img/bankidlogo.png',
              width: 30,
            ),
            const Text(
              'Bank-ID på denna enhet',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            const Expanded(child: SizedBox()),
            TextButton(
              onPressed: () {
              },
              child: const Text(
                '->',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Image.asset(
              'assets/img/bankidlogo.png',
              width: 30,
            ),
            const Text(
              'Bank-ID på annan enhet',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            const Expanded(child: SizedBox()),
            TextButton(
              onPressed: () {
                // Placeholder for another page if needed
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BankidAnnanenhet(),
                  ),
                );
              },
              child: const Text(
                '->',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Text(
              'Personlig kod',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            const Expanded(child: SizedBox()),
            TextButton(
              onPressed: () {
                // Navigate to Personal Code login page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PersonligKod(),
                  ),
                );
              },
              child: const Text(
                '->',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
      ],
    );
  }
}