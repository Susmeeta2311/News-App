import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/news_model.dart';
import '../services/network_services.dart';

class NewsController extends GetxController {
  final isDarkMode = false.obs;
  final selectedCategory = "General".obs;
  final articles = <Article>[].obs;
  final isLoading = false.obs;

  final NetworkServices _networkServices = NetworkServices();

  void onThemeClicked() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  void categorySelection(String category) {
    selectedCategory.value = category;
    fetchNews();
  }

  Future<void> fetchNews() async {
    isLoading.value = true;
    try {
      final news = await _networkServices.fetchNews(selectedCategory.value);
      articles.assignAll(news.articles ?? []);
    } catch (e) {
      print("Error fetching news: $e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    fetchNews();
    super.onInit();
  }
}

