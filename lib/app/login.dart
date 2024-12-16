import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/app/quiz_screen.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isSignUp = true; // True bo'lsa, Sign Up, False bo'lsa Sign In

  // Sign Up funksiyasi
  Future<void> _signUp() async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // Success
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => QuizScreen()),
      );
    } catch (e) {
      _showError(e.toString());
    }
  }

  // Sign In funksiyasi
  Future<void> _signIn() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // Success
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => QuizScreen()),
      );
    } catch (e) {
      _showError(e.toString());
    }
  }

  // Error ko'rsatish uchun funksiya
  void _showError(String error) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(error),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
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
        title: Text(_isSignUp ? 'Sign Up' : 'Sign In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isSignUp ? _signUp : _signIn,
              child: Text(_isSignUp ? 'Sign Up' : 'Sign In'),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                setState(() {
                  _isSignUp = !_isSignUp;
                });
              },
              child: Text(_isSignUp
                  ? 'Already have an account? Sign In'
                  : 'Don\'t have an account? Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
