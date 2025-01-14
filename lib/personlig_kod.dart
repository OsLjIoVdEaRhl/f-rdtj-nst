import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:logger/logger.dart';
import 'package:hive/hive.dart';
import 'home_page.dart';
import 'register_page.dart';

class PersonligKod extends StatefulWidget {
  const PersonligKod({super.key});

  @override
  State<PersonligKod> createState() => _PersonligKodState();
}

class _PersonligKodState extends State<PersonligKod> {
  final TextEditingController _codeController = TextEditingController();
  final pb = PocketBase('https://fardtjanst-pb.cloud.spetsen.net'); // Use the correct base URL
  final logger = Logger();
  bool _staySignedIn = false;

  @override
  void initState() {
    super.initState();
    _checkAuthState();
  }

  Future<void> _checkAuthState() async {
    try {
      var box = await Hive.openBox('authBox');
      final token = box.get('auth_token');
      if (token != null && mounted) {
        // Navigate to HomePage if the user is already authenticated
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        });
      }
    } catch (e) {
      logger.e('Error checking auth state: $e');
    }
  }

  Future<void> _submitCode() async {
    final enteredCode = _codeController.text;
    if (enteredCode.isEmpty) {
      _showDialog('Error', 'Field cannot be empty.');
      return;
    }

    try {
      // Fetch user record with the entered password (assuming 'password' is a field)
      logger.d('Fetching user with password...');
      final records = await pb.collection('personlig_kod').getFullList(
        filter: 'password="$enteredCode"',
      );
      if (records.isNotEmpty) {
        logger.d('Authentication successful');
        if (_staySignedIn) {
          var box = await Hive.openBox('authBox');
          await box.put('auth_token', 'your_auth_token'); // Store the auth token
        }
        _showDialog('Success', 'User logged in.', () {
          _navigateToHomePage();
        });
      } else {
        logger.d('Authentication failed');
        _showDialog('Error', 'No user found with this password.');
      }
    } catch (e) {
      logger.e('Error: $e');
      _showDialog('Error', 'An error occurred: ${e.toString()}');
    }
  }

  void _navigateToHomePage() {
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
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
        title: Text('Personlig Kod'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _codeController,
              decoration: InputDecoration(labelText: 'Personlig Kod'),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Stay Signed In'),
                Switch(
                  value: _staySignedIn,
                  onChanged: (value) {
                    setState(() {
                      _staySignedIn = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitCode,
              child: Text('Logga in'),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              child: Text('Register Now'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }
}