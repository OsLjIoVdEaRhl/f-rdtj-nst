import 'package:flutter/material.dart';

class LoginHelp extends StatefulWidget {
  const LoginHelp({super.key});

  @override
  State<LoginHelp> createState() => _LoginHelpState();
}

class _LoginHelpState extends State<LoginHelp> {
  // State variables to control visibility of text for each row
  bool _showTextRow1 = false;
  bool _showTextRow2 = false;
  bool _showTextRow3 = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () {
                setState(() {
                  _showTextRow1 = !_showTextRow1; // Toggle visibility
                });
              },
              child: const Text(
                'Hur man loggar in Bank-ID på denna enhet',
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
            if (_showTextRow1)
              const Text(
                'Du kommer att öppna Bank-ID appen skriva under. Därefter öppnar du färdtjänsappen igen och du är inloggad',
                style: TextStyle(fontSize: 14, color: Colors.white70),
              ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () {
                setState(() {
                  _showTextRow2 = !_showTextRow2; // Toggle visibility
                });
              },
              child: const Text(
                'Hur man loggar in med Bank-ID på annan enhet',
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
            if (_showTextRow2)
              const Text(
                'Information: Detta är hur man loggar in med Bank-ID på annan enhet.',
                style: TextStyle(fontSize: 14, color: Colors.white70),
              ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () {
                setState(() {
                  _showTextRow3 = !_showTextRow3; // Toggle visibility
                });
              },
              child: const Text(
                'Hur man loggar in med personlig kod',
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
            if (_showTextRow3)
              const Text(
                'Information: Detta är hur man loggar in med personlig kod.',
                style: TextStyle(fontSize: 14, color: Colors.white70),
              ),
          ],
        ),
      ],
    );
  }
}
