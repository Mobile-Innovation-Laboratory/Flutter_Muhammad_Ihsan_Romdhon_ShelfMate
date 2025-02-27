import 'package:get/get.dart';
import 'package:shelfmate/screens/book_detail_screen.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import '../screens/main_navigation.dart';
import '../screens/home_screen.dart';
import '../screens/favorite_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/book_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String main = '/main';
  static const String favorite = '/favorite';
  static const String profile = '/profile';
  static const String book = '/book';
  static const String detail = '/detail';

  static List<GetPage> routes = [
    GetPage(name: login, page: () => LoginScreen()),
    GetPage(name: register, page: () => RegisterScreen()),
    GetPage(name: main, page: () => MainNavigation()),
    GetPage(name: home, page: () => HomeScreen()),
    GetPage(name: favorite, page: () => FavoriteScreen()),
    GetPage(name: profile, page: () => ProfileScreen()),
    GetPage(name: book, page: () => BookScreen()),
    GetPage(name: detail, page: () => BookDetailScreen()),
  ];
}
