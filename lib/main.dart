import 'package:flutter/material.dart';
import 'features/auth/spalsh_screen.dart'; // Ensure this path is correct

void main() {
  runApp(const RobokalamApp());
}

class RobokalamApp extends StatelessWidget {
  const RobokalamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Robokalam App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true, // Remove this if your Flutter version is old
      ),
      home: const SplashScreen(),
    );
  }
}
