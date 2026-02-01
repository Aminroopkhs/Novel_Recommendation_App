import 'package:flutter/material.dart';
import '../../services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<dynamic>> novelsFuture;

  @override
  void initState() {
    super.initState();
    novelsFuture = ApiService.fetchAllNovels();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1208),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1208),
        title: const Text("Discover Novels 📖"),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: novelsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text(
                "Failed to load novels",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          final novels = snapshot.data!;

          return ListView.builder(
            itemCount: novels.length,
            itemBuilder: (context, index) {
              final novel = novels[index];
              return ListTile(
                title: Text(
                  novel["title"],
                  style: const TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  novel["author"] ?? "",
                  style: const TextStyle(color: Colors.white70),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
