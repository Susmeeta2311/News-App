import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../model/news_model.dart';
import '../services/network_services.dart';

class NewsController extends GetxController {
  final isDarkMode = false.obs;
  final selectedCategory = "General".obs;
  final articles = <Article>[].obs;
  final isLoading = false.obs;

  final NetworkServices _networkServices = NetworkServices();

  // News Reading History
  final newsHistory = <Map<String, dynamic>>[].obs;

  void addToHistory(Map<String, dynamic> newsItem) {
    newsHistory.add(newsItem);
  }

  void clearAllHistory() {
    newsHistory.clear();
  }

  void onThemeClicked() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  void categorySelection(String category) {
    if (selectedCategory.value != category) {
      selectedCategory.value = category;
      fetchNews();
    }
  }

  Future<void> fetchNews() async {
    isLoading.value = true;
    try {
      final news = await _networkServices
          .fetchNews(selectedCategory.value.toLowerCase());

      articles.clear();
      articles.assignAll(news.articles ?? []);
    } catch (e) {
      print("Error fetching news: $e");
    } finally {
      isLoading.value = false;
    }
  }

  String formatDate(dynamic dateInput) {
    if (dateInput == null || dateInput.toString().isEmpty) {
      return "Unknown Date";
    }
    try {
      DateTime date = DateTime.parse(dateInput.toString());
      return DateFormat("MMMM d, yyyy").format(date);
    } catch (e) {
      return "Invalid Date";
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchNews();
  }
}
