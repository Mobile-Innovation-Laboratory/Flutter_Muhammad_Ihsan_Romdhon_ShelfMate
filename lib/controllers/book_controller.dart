import 'package:get/get.dart';
import '../services/book_service.dart';

class BookController extends GetxController {
  var books = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;

  void searchBooks(String query) async {
    try {
      isLoading.value = true;
      final results = await BookService.searchBooks(query);
      books.assignAll(results);
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
