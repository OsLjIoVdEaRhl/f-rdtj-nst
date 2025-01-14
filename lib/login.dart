import 'package:flutter/material.dart';
import 'package:fardtjanst/login_alternative.dart';
import 'package:fardtjanst/login_help.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 223, 235, 248),
      appBar: AppBar(
        title: const Text('Färdtjänsten'),
        backgroundColor: const Color.fromARGB(255, 6, 63, 121),
        centerTitle: true,

      ),
    body: Column(
      children: [
        Container(height: 30,),
          Container(
            decoration: BoxDecoration (borderRadius: BorderRadius.circular(7),
            color: const Color.fromARGB(255, 8, 6, 78),), 
            width: 350,
            height: 400,
            padding: const EdgeInsets.all(30),
            child: const LoginAlternative(),
          ),
        Container(height: 30,),
          Container(
            decoration: BoxDecoration (borderRadius: BorderRadius.circular(7),
            color: const Color.fromARGB(255, 8, 6, 78),), 
            width: 350,
            height: 252,
            padding: const EdgeInsets.all(2),
            child: const LoginHelp(),
          ),
        ],
      ),
    );
  }
}
