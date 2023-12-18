import 'package:flutter/material.dart';
import 'package:neuflo_learn/dashboard.dart';
import 'package:neuflo_learn/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signInWithEmailAndPassword(BuildContext context) async {
  try {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );

    // Navigate to the DashboardPage after successful login
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DashboardPage()),
    );
  } catch (e) {
    // Handle login failure, show an error dialog to the user
    print('Error signing in: $e');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login Failed'),
          content: Text('Invalid email or password. Please try again.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                signInWithEmailAndPassword(context);
              },
              child: Text('Login'),
            ),
            SizedBox(height: 16),
            Text('Don\'t have an account?'),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              },
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}