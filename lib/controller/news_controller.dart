import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewsController extends GetxController {
  final isDarkMode = false.obs;

  void onThemeClicked() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }
}
