import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the current user from Firebase Authentication
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Photo (Default image if none)
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(user?.photoURL ?? 'https://i.stack.imgur.com/l60Hf.png'),
            ),
            SizedBox(height: 16),
            // Name (First Name + Last Name)
            Text(
              'Username: ${user?.displayName ?? "N/A"}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            // Date of Birth (Assuming it's stored in Firestore)
            FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance.collection('users').doc(user?.uid).get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  // Display Date of Birth
                  var userData = snapshot.data?.data() as Map<String, dynamic>?;

                  return Column(
                    children: [
                      SizedBox(height: 8),
                      Text('Date of Birth: ${userData?['dob'] ?? "N/A"}'),
                    ],
                  );
                }
              },
            ),
            // Institution (Assuming it's stored in Firestore)
            FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance.collection('users').doc(user?.uid).get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  // Display Institution
                  var userData = snapshot.data?.data() as Map<String, dynamic>?;

                  return Column(
                    children: [
                      SizedBox(height: 8),
                      Text('Institution: ${userData?['institution'] ?? "N/A"}'),
                    ],
                  );
                }
              },
            ),
            // Subscription Status (Assuming it's stored in Firestore)
            FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance.collection('users').doc(user?.uid).get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  // Display Subscription Status
                  var userData = snapshot.data?.data() as Map<String, dynamic>?;

                  return Column(
                    children: [
                      SizedBox(height: 8),
                      Text('Subscription Status: ${userData?['subscriptionStatus'] ?? "N/A"}'),
                    ],
                  );
                }
              },
            ),
            // Edit Profile button
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navigate to Edit Profile Page
                // Add your navigation logic here
              },
              child: Text('Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
