import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/database/database_helper.dart';
import '../model/news_model.dart';
import '../services/network_services.dart';

class NewsController extends GetxController {
  final isDarkMode = false.obs;
  final selectedCategory = "General".obs;
  final articles = <Article>[].obs;
  final isLoading = false.obs;

  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  RxList<Map<String, dynamic>> newsHistory = <Map<String, dynamic>>[].obs;

  final NetworkServices _networkServices = NetworkServices();

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

  // Fetch news history from the database
  Future<void> fetchHistory() async {
    final data = await dbHelper.getNewsHistory();
    newsHistory.assignAll(data);
  }

  // Add news to history
  Future<void> addToHistory(String title, String description, String url, String imageUrl, String publishedAt) async {
    await dbHelper.insertNews({
      'title': title,
      'description': description,
      'url': url,
      'imageUrl': imageUrl,
      'publishedAt': publishedAt,
    });
     fetchHistory(); // Refresh history after inserting
  }

  Future<void> deleteHistory(int id) async {
    await dbHelper.deleteNews(id);
    await fetchHistory();
  }

  Future<void> clearAllHistory() async {
    await dbHelper.clearHistory();
    await fetchHistory();
  }

  Future<void> fetchNews() async {
    isLoading.value = true;
    try {
      final news = await _networkServices.fetchNews(selectedCategory.value.toLowerCase());

      articles.clear();
      articles.assignAll(news.articles ?? []);
    } catch (e) {
      print("Error fetching news: $e");
    } finally {
      isLoading.value = false;
    }
  }

  String formatDate(dynamic dateInput) {
    if (dateInput == null || dateInput.toString().isEmpty) return "Unknown Date";
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
    fetchHistory();
  }
}
