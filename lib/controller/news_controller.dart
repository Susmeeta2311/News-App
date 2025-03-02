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

  void onThemeClicked() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  void categorySelection(String category) {
    if (selectedCategory.value != category) {
      selectedCategory.value = category;
      print("Selected category changed to: $category"); // Debugging
      fetchNews();
    }
  }

  Future<void> fetchNews() async {
    isLoading.value = true;

    // Print to debug category selection
    print("Fetching news for category: ${selectedCategory.value}");

    try {
      // Fetch the news based on the selected category
      final news = await _networkServices.fetchNews(selectedCategory.value.toLowerCase());

      // Debugging: Print number of articles received
      print("Articles received: ${news.articles?.length}");

      // Clear previous articles before adding new ones
      articles.clear();
      articles.assignAll(news.articles ?? []);
    } catch (e) {
      print("Error fetching news: $e");
    } finally {
      isLoading.value = false;
    }
  }

  String formatDate(dynamic dateInput) {
    if (dateInput == null) return "Unknown Date";

    try {
      DateTime date;
      if (dateInput is DateTime) {
        date = dateInput;
      } else if (dateInput is String) {
        date = DateTime.parse(dateInput);
      } else {
        return "Invalid Date";
      }
      return DateFormat("MMMM d, yyyy").format(date);
    } catch (e) {
      return "Invalid Date";
    }
  }

  @override
  void onInit() {
    fetchNews();
    super.onInit();
  }
}
