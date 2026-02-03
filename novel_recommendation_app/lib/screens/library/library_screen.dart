import 'package:flutter/material.dart';
import '../../models/novel.dart';
import '../../services/api_service.dart';
import '../novel/novel_detail_screen.dart';

class LibraryScreen extends StatefulWidget {
  final int userId;
  const LibraryScreen({super.key, required this.userId});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  late Future<List<Novel>> _libraryFuture;

  @override
  void initState() {
    super.initState();
    _libraryFuture = ApiService.fetchLibrary(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Library")),
      body: FutureBuilder<List<Novel>>(
        future: _libraryFuture,
        builder: (_, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return const Center(child: Text("Failed to load library"));
          }

          final novels = snap.data!;
          if (novels.isEmpty) {
            return const Center(child: Text("Your library is empty"));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: novels.length,
            itemBuilder: (_, i) {
              final n = novels[i];
              return ListTile(
                leading: Image.network(n.imageUrl, width: 50, fit: BoxFit.cover),
                title: Text(n.title),
                subtitle: Text(n.author),
                trailing: IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: () async {
                    await ApiService.removeFromLibrary(widget.userId, n.id);
                    setState(() {
                      _libraryFuture =
                          ApiService.fetchLibrary(widget.userId);
                    });
                  },
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => NovelDetailScreen(novel: n),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
