import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:logger/logger.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final pb = PocketBase('https://fardtjanst-pb.cloud.spetsen.net'); // Use the correct base URL
  final logger = Logger();

  Future<void> _register() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      _showDialog('Error', 'Email and password fields cannot be empty.');
      return;
    }

    if (password != confirmPassword) {
      _showDialog('Error', 'Passwords do not match.');
      return;
    }

    try {
      // Check if the user already exists
      final existingUsers = await pb.collection('personlig_kod').getFullList(
        filter: 'email="$email"',
      );

      if (existingUsers.isNotEmpty) {
        _showDialog('Error', 'User already exists.');
        return;
      }

      // Create a new user record
      await pb.collection('personlig_kod').create(body: {
        'email': email,
        'password': password,
        'passwordConfirm': password, // Required for user creation
      });

      _showDialog('Success', 'User registered successfully.', () {
        Navigator.pop(context); // Go back to the previous page
      });
    } catch (e) {
      logger.e('Error: $e');
      _showDialog('Error', 'An error occurred: ${e.toString()}');
    }
  }

  void _showDialog(String title, String content, [VoidCallback? onOkPressed]) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                if (onOkPressed != null) {
                  onOkPressed();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(labelText: 'Confirm Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _register,
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}