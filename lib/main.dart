import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';

/// Entry point of the application.
void main() {
  runApp(const MyApp());
}

/// The root widget of the application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Authentication',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/', // Set initial route to LoginScreen
      routes: {
        '/': (context) => LoginScreen(), // Route to LoginScreen
        '/home': (context) => const HomeScreen(userInfo: {}, userEmail: null), // Route to HomeScreen with empty userInfo
      },
    );
  }
}
