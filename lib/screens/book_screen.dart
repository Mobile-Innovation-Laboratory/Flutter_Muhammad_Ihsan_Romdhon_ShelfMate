import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shelfmate/screens/book_detail_screen.dart';
import '../controllers/book_controller.dart';

class BookScreen extends StatelessWidget {
  final BookController bookController = Get.put(BookController());
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cari Buku")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: "Cari Buku",
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    bookController.searchBooks(searchController.text);
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (bookController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              if (bookController.books.isEmpty) {
                return Center(child: Text("Tidak ada hasil"));
              }
              return ListView.builder(
                itemCount: bookController.books.length,
                itemBuilder: (context, index) {
                  final book = bookController.books[index];
                  return ListTile(
                    leading: book['cover'] != null
                        ? Image.network(book['cover'], width: 50)
                        : Icon(Icons.book),
                    title: Text(book['title']),
                    subtitle: Text("Penulis: ${book['author']}"),
                    onTap: () {
                      Get.to(() => BookDetailScreen(), arguments: book);
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
