import 'package:flutter/material.dart';
import 'package:neuflo_learn/accountpage.dart';
// Import your account page file

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              // Navigate to the account page when the icon is pressed
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AccountPage()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Your Dashboard',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Add other dashboard content here
          ],
        ),
      ),
    );
  }
}
