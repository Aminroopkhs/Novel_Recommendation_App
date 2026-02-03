import 'package:flutter/material.dart';
import '../../models/novel.dart';
import '../../services/api_service.dart';
import '../novel/novel_detail_screen.dart';

class WishlistScreen extends StatefulWidget {
  final int userId;
  const WishlistScreen({super.key, required this.userId});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  late Future<List<Novel>> _wishlistFuture;

  @override
  void initState() {
    super.initState();
    _wishlistFuture = ApiService.fetchWishlist(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Wishlist")),
      body: FutureBuilder<List<Novel>>(
        future: _wishlistFuture,
        builder: (_, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return const Center(child: Text("Failed to load wishlist"));
          }

          final novels = snap.data!;
          if (novels.isEmpty) {
            return const Center(child: Text("Your wishlist is empty"));
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
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () async {
                    await ApiService.removeFromWishlist(widget.userId, n.id);
                    setState(() {
                      _wishlistFuture =
                          ApiService.fetchWishlist(widget.userId);
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
