import 'package:flutter/material.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/custom_button.dart';
import 'signup_screen.dart';
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF2B1D0E),
              Color(0xFF1C1208),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: 380,
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.35),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 30,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.auto_stories,
                    color: Color(0xFFFFD166),
                    size: 60,
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    "Welcome to BookNest",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    "Dive into your next great read",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),

                  const SizedBox(height: 30),

                  const CustomTextField(
                    hint: "Email",
                    icon: Icons.email_outlined,
                  ),

                  const SizedBox(height: 16),

                  const CustomTextField(
                    hint: "Password",
                    icon: Icons.lock_outline,
                    obscure: true,
                  ),

                  const SizedBox(height: 26),

                  CustomButton(
                    text: "Login",
                    onTap: () {
                      print("Login tapped");
                    },
                  ),

                  const SizedBox(height: 16),

                  TextButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignupScreen(),
      ),
    );
  },
  child: const Text(
    "New here? Sign up",
    style: TextStyle(
      color: Color(0xFFFFD166),
    ),
  ),
)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
