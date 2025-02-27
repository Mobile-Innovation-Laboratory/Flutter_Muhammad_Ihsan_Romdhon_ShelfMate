import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../components/user_data_field.dart';
import '../components/gender_button.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatelessWidget {
  final AuthController authController = Get.find();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController favoriteGenreController = TextEditingController();
  var selectedGender = "".obs;

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profil Saya")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(() {
                  final user = authController.firebaseUser.value;
                  nameController.text = user?.displayName ?? "Guest";

                  return Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          user?.photoURL ?? "https://via.placeholder.com/150",
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        user?.email ?? "",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  );
                }),
                const SizedBox(height: 50),
                UserDataField(
                  label: "Nama",
                  controller: authController.nameController,
                ),
                const SizedBox(height: 30),
                UserDataField(
                  label: "Genre Buku Favorit",
                  controller: favoriteGenreController
                    ..text = authController.favoriteGenre.value,
                ),
                const SizedBox(height: 30),
                Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GenderButton(
                          label: "Pria",
                          isSelected: authController.gender.value == "Pria",
                          onTap: () => authController.gender.value = "Pria",
                        ),
                        const SizedBox(width: 10),
                        GenderButton(
                          label: "Wanita",
                          isSelected: authController.gender.value == "Wanita",
                          onTap: () => authController.gender.value = "Wanita",
                        ),
                      ],
                    )),
                const SizedBox(height: 50),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      authController.updateUserProfile(
                        name: nameController.text,
                        gender: selectedGender.value,
                        favoriteGenre: favoriteGenreController.text,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Simpan Perubahan",
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: authController.logoutUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Logout",
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
