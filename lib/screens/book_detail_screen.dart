import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shelfmate/controllers/favorite_controller.dart';

class BookDetailScreen extends StatelessWidget {
  final FavoriteController favoriteController = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> book = Get.arguments;

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFF5F6F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () => Get.back(),
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: EdgeInsets.zero,
              elevation: 0,
              backgroundColor: Colors.white,
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 20,
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          Center(
            child: book['cover'] != null
                ? Image.network(book['cover'], height: 250)
                : Icon(Icons.book, size: 120, color: Colors.grey[700]),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book['title'] ?? 'Tidak ada judul',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text("Penulis: ${book['author'] ?? 'Tidak diketahui'}",
                    style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 10),
                const Text("Deskripsi:",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Text(
                  book['description'] ??
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam eget nunc ut libero viverra elementum. Integer tincidunt urna in libero tincidunt, a dictum massa fringilla.",
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, -1),
              blurRadius: 6,
            ),
          ],
        ),
        child: SafeArea(
          child: ElevatedButton(
            onPressed: () => favoriteController.toggleFavorite(book),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2E4660),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Obx(() {
              final isFav = favoriteController.isFavorite(book);
              return Text(
                isFav ? "Remove from Favorite" : "Add to Favorite",
                style: const TextStyle(fontSize: 18, color: Colors.white),
              );
            }),
          ),
        ),
      ),
    );
  }
}
