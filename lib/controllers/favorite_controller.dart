import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FavoriteController extends GetxController {
  var favoriteBooks = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }

  void toggleFavorite(Map<String, dynamic> book) async {
    if (isFavorite(book)) {
      favoriteBooks.removeWhere((b) => b['id'] == book['id']);
    } else {
      favoriteBooks.add(book);
    }
    saveFavorites();
  }

  bool isFavorite(Map<String, dynamic> book) {
    return favoriteBooks.any((b) => b['id'] == book['id']);
  }

  void saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('favoriteBooks', jsonEncode(favoriteBooks));
  }

  void loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final savedData = prefs.getString('favoriteBooks');

    if (savedData != null) {
      try {
        final decodedData = jsonDecode(savedData);

        if (decodedData is List) {
          favoriteBooks.assignAll(List<Map<String, dynamic>>.from(decodedData));
        } else {
          favoriteBooks.clear();
        }
      } catch (e) {
        print("Error parsing favorite books: $e");
        favoriteBooks.clear();
      }
    }
  }
}
