import 'package:flutter/material.dart';
import 'package:neuflo_learn/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController userIDController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: firstNameController,
                decoration: InputDecoration(labelText: 'First Name'),
              ),
              TextField(
                controller: lastNameController,
                decoration: InputDecoration(labelText: 'Last Name'),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: phoneNumberController,
                decoration: InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
              ),
              TextField(
                controller: userIDController,
                decoration: InputDecoration(labelText: 'UserID'),
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  try {
                    UserCredential userCredential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text,
                    );

                    // Send email verification
                    await userCredential.user!.sendEmailVerification();

                    // Save user details to Firestore
                    String userUid = userCredential.user!.uid;
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(userUid)
                        .set({
                      'firstName': firstNameController.text,
                      'lastName': lastNameController.text,
                      'email': emailController.text,
                      'phoneNumber': phoneNumberController.text,
                      'userName': userIDController.text,
                    });

                    // Navigate to the DashboardPage after signing up
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DashboardPage()),
                    );
                  } catch (e) {
                    print('Error signing up: $e');

                    if (e is FirebaseAuthException &&
                        e.code == 'invalid-email') {
                      // Handle invalid email
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Sign Up Failed'),
                            content: Text(
                                'The email address is badly formatted. Please enter a valid email address.'),
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
                    } else if (e is FirebaseAuthException &&
                        e.code == 'weak-password') {
                      // Handle weak password
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Sign Up Failed'),
                            content: Text(
                                'The password should have at least 6 characters.'),
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
                    } else {
                      // Handle other errors
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Sign Up Failed'),
                            content: Text(
                                'An error occurred during sign-up. Please try again.'),
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
                },
                child: Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
