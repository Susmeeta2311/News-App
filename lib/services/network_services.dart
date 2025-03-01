import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/news_model.dart';

class NetworkServices {
  /// BASE URL WITHOUT DEFAULT CATEGORY
  final String baseUrl = "https://gnews.io/api/v4/top-headlines";
  final String key = "f37f7bbcfa107ac9544356c64393805f";

  /// FETCH NEWS BASE ON CATEGORY
  Future<NewsModel> fetchNews(String category) async {
    final Uri url = Uri.parse("$baseUrl?category=$category&lang=en&country=in&max=10&token=$key");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return newsModelFromJson(response.body);
      } else {
        throw Exception("Failed to load news: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching news: $e");
    }
  }
}
