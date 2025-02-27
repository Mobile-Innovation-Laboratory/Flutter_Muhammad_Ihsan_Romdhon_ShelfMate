import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shelfmate/screens/book_detail_screen.dart';
import '../controllers/book_controller.dart';
import 'book_screen.dart';
import 'dart:math';

class HomeScreen extends StatelessWidget {
  final BookController bookController = Get.put(BookController());
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/onlyLogo.png',
              height: 30,
              width: 30,
            ),
            SizedBox(width: 8),
            Text(
              "ShelfMate",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF2E4660),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onTap: () {
                      Get.to(() => BookScreen());
                    },
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: "Cari Buku...",
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    Get.to(() => BookScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(14),
                    backgroundColor: const Color(0xFF2E4660),
                  ),
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              "Buku Populer 🔥",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              height: 180,
              child: Obx(() {
                if (bookController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }
                if (bookController.books.isEmpty) {
                  return Center(child: Text("Tidak ada buku ditemukan"));
                }

                final random = Random();
                final shuffledBooks = List.from(bookController.books)
                  ..shuffle(random);

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: min(6, shuffledBooks.length),
                  itemBuilder: (context, index) {
                    final book = shuffledBooks[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => BookDetailScreen(), arguments: book);
                      },
                      child: Container(
                        width: 120,
                        margin: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 4)
                          ],
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(12)),
                              child: Image.network(
                                book['cover'] ??
                                    "https://via.placeholder.com/150",
                                height: 120,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                book['title'],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
            SizedBox(height: 20),
            Text(
              "Buku Rekomendasi 📚",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Obx(() {
              if (bookController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              if (bookController.books.isEmpty) {
                return Center(child: Text("Tidak ada buku ditemukan"));
              }

              final random = Random();
              final shuffledBooks = List.from(bookController.books)
                ..shuffle(random);

              return Wrap(
                spacing: 10,
                runSpacing: 10,
                children: List.generate(
                  min(6, shuffledBooks.length),
                  (index) {
                    final book = shuffledBooks[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => BookDetailScreen(), arguments: book);
                      },
                      child: Container(
                        width: (MediaQuery.of(context).size.width - 42) /
                            2, // 2 columns
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 4)
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(12)),
                              child: Image.network(
                                book['cover'] ??
                                    "https://via.placeholder.com/150",
                                height: 150,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    book['title'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "Penulis: ${book['author']}",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
            SizedBox(height: 20),
            Text(
              "Buku Terbaru 🌟",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Obx(() {
              if (bookController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              if (bookController.books.isEmpty) {
                return Center(child: Text("Tidak ada buku ditemukan"));
              }

              final random = Random();
              final shuffledBooks = List.from(bookController.books)
                ..shuffle(random);

              return Column(
                children: List.generate(
                  min(6, shuffledBooks.length),
                  (index) {
                    final book = shuffledBooks[index];
                    return ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          book['cover'] ?? "https://via.placeholder.com/150",
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        book['title'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        "Penulis: ${book['author']}",
                        style: TextStyle(color: Colors.grey),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      onTap: () {
                        Get.to(() => BookDetailScreen(), arguments: book);
                      },
                    );
                  },
                ),
              );
            }),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
