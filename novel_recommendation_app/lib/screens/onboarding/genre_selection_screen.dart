import 'package:flutter/material.dart';
import '../home/home_screen.dart';

class GenreSelectionScreen extends StatefulWidget {
  const GenreSelectionScreen({super.key});

  @override
  State<GenreSelectionScreen> createState() => _GenreSelectionScreenState();
}

class _GenreSelectionScreenState extends State<GenreSelectionScreen> {
  final List<String> genres = [
    "Comedy 😂",
    "Horror 👻",
    "Sci-Fi 🚀",
    "Romance 💕",
    "Mystery 🕵️",
  ];

  final Set<String> selectedGenres = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1208),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Pick your favorite genres",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "This helps us recommend better novels",
                style: TextStyle(color: Colors.white70),
              ),

              const SizedBox(height: 30),

              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: genres.map((genre) {
                  final isSelected = selectedGenres.contains(genre);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        isSelected
                            ? selectedGenres.remove(genre)
                            : selectedGenres.add(genre);
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFFE07A2D)
                            : Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        genre,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                }).toList(),
              ),

              const Spacer(),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE07A2D),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: selectedGenres.isEmpty
                    ? null
                    : () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                        );
                      },
                child: const Text("Continue"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
