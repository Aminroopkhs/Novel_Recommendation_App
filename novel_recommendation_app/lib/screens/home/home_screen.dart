import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1208),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1208),
        title: const Text("Recommended for You 📚"),
      ),
      body: const Center(
        child: Text(
          "Your novels will appear here",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
