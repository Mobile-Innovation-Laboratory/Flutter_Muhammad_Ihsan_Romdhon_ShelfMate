import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/local_storage.dart';
import '../routes/app_routes.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var isLoading = false.obs;
  var firebaseUser = Rx<User?>(null);
  final TextEditingController nameController = TextEditingController();
  final TextEditingController favoriteGenreController = TextEditingController();

  var userName = "".obs;
  var gender = "".obs;
  var favoriteGenre = "".obs;

  @override
  void onInit() {
    super.onInit();
    firebaseUser.bindStream(_auth.authStateChanges());
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userData = await LocalStorage.getUserData();

    userName.value = userData['name'] ?? "User";
    gender.value = userData['gender'] ?? "Pria";
    favoriteGenre.value = userData['favoriteGenre'] ?? "";

    nameController.text = userName.value;
    favoriteGenreController.text = favoriteGenre.value;
  }

  Future<void> loginUser(String email, String password) async {
    try {
      isLoading.value = true;
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      firebaseUser.value = userCredential.user;

      await LocalStorage.clearUserData();

      String name = userCredential.user?.displayName ?? "User";

      await LocalStorage.saveUserData(
        email: email,
        name: name,
        gender: "Pria",
        favoriteGenre: "",
      );

      await _loadUserData();

      Get.offAllNamed(AppRoutes.main);
    } catch (e) {
      Get.snackbar("Error", "Login gagal");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> registerUser(String email, String password) async {
    try {
      isLoading.value = true;
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredential.user?.updateDisplayName("User");
      firebaseUser.value = userCredential.user;

      await LocalStorage.saveUserData(
        email: email,
        name: "User",
        gender: "Pria",
        favoriteGenre: "",
      );

      Get.snackbar("Sukses", "Akun berhasil dibuat!");
      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      Get.snackbar("Error", "Pendaftaran gagal");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateUserProfile({
    required String name,
    required String gender,
    required String favoriteGenre,
  }) async {
    try {
      isLoading.value = true;
      User? user = _auth.currentUser;

      if (user != null) {
        await user.updateDisplayName(name);
        await user.reload();

        firebaseUser.value = _auth.currentUser;

        await LocalStorage.saveUserData(
          email: user.email ?? "",
          name: name,
          gender: gender,
          favoriteGenre: favoriteGenre,
        );

        Get.snackbar("Sukses", "Profil berhasil diperbarui!");
      }
    } catch (e) {
      Get.snackbar("Error", "Gagal memperbarui profil.");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logoutUser() async {
    await _auth.signOut();
    firebaseUser.value = null;

    await LocalStorage.clearUserData();

    userName.value = "";
    gender.value = "";
    favoriteGenre.value = "";

    Get.offAllNamed(AppRoutes.login);
  }
}
