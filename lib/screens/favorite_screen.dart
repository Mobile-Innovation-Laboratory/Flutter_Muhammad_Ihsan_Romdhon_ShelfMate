import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/favorite_controller.dart';
import 'book_detail_screen.dart';

class FavoriteScreen extends StatelessWidget {
  final FavoriteController favoriteController = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Buku Favorit")),
      body: Obx(() {
        if (favoriteController.favoriteBooks.isEmpty) {
          return Center(child: Text("Belum ada buku favorit"));
        }
        return ListView.builder(
          itemCount: favoriteController.favoriteBooks.length,
          itemBuilder: (context, index) {
            final book = favoriteController.favoriteBooks[index];
            return ListTile(
              leading: Image.network(book['cover'], width: 50),
              title: Text(book['title']),
              subtitle: Text(book['author']),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  favoriteController.toggleFavorite(book);
                },
              ),
              onTap: () {
                Get.to(() => BookDetailScreen(), arguments: book);
              },
            );
          },
        );
      }),
    );
  }
}
