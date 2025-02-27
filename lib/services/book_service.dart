import 'dart:convert';
import 'package:http/http.dart' as http;

class BookService {
  static Future<List<Map<String, dynamic>>> searchBooks(String query) async {
    final url = Uri.parse('https://openlibrary.org/search.json?q=$query');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final books = data['docs'].map<Map<String, dynamic>>((book) {
        return {
          'title': book['title'] ?? 'Unknown Title',
          'author': book['author_name']?.first ?? 'Unknown Author',
          'cover': book['cover_i'] != null
              ? 'https://covers.openlibrary.org/b/id/${book['cover_i']}-M.jpg'
              : null,
        };
      }).toList();
      return books;
    } else {
      throw Exception('Gagal mengambil data buku');
    }
  }
}
