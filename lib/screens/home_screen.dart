import 'package:flutter/material.dart';

/// Home screen displayed after successful login.
class HomeScreen extends StatelessWidget {
  /// User information received after authentication.
  final Map<String, dynamic> userInfo;

  /// Constructor for HomeScreen.
  const HomeScreen({super.key, required this.userInfo, required userEmail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Welcome Text
            const Text(
              'Welcome!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // User Profile Picture
            CircleAvatar(
              radius: 80, // Increased avatar size
              backgroundImage: NetworkImage(userInfo['picture'] ?? ''),
            ),
            const SizedBox(height: 20),
            // User Name
            Text(
              'Name: ${userInfo['name']}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // User Email
            Text(
              'Email: ${userInfo['email']}',
              style: const TextStyle(fontSize: 18),
            ),
            // Add more user information fields as needed
          ],
        ),
      ),
    );
  }
}
