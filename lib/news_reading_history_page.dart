import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp/controller/news_controller.dart';
import 'package:intl/intl.dart';

class NewsReadingHistoryPage extends GetView<NewsController> {
  const NewsReadingHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Reading History",
          style: TextStyle(color: Colors.white, fontSize: 22.0),
        ),
        backgroundColor: Get.isDarkMode ? Color(0xff343a40) : Colors.blueAccent,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            onPressed: () {
              if (controller.newsHistory.isNotEmpty) {
                Get.dialog(
                  Dialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Clear History",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Are you sure you want to clear your reading history?",
                            style: TextStyle(
                              fontSize: 16,
                              color: Get.isDarkMode
                                  ? Colors.white
                                  : Colors
                                      .black87,
                            ),
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () => Get.back(),
                                child: Text("Cancel",
                                    style: TextStyle(
                                        color: Color(0xff9d4edd),
                                        fontSize: 16)),
                              ),
                              SizedBox(width: 10),
                              TextButton(
                                onPressed: () {
                                  controller.clearAllHistory();
                                  Get.back();
                                  Get.snackbar("Deleted",
                                      "Reading history cleared successfully!",
                                      snackPosition: SnackPosition.BOTTOM);
                                },
                                child: Text("Clear",
                                    style: TextStyle(
                                        color: Color(0xff9d4edd),
                                        fontSize: 16)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            },
            icon: Icon(Icons.delete_outline_outlined, color: Colors.white),
          )
        ],
      ),
      body: Obx(() {
        if (controller.newsHistory.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.history, size: 70.0, color: Colors.grey),
                SizedBox(height: 10.0),
                Text("No reading history",
                    style: TextStyle(fontSize: 18, color: Colors.grey)),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: controller.newsHistory.length,
          itemBuilder: (context, index) {
            final newsItem = controller.newsHistory[index];

            return Card(
              margin:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // IMAGE
                  if (newsItem['imageUrl'] != null &&
                      newsItem['imageUrl'].isNotEmpty)
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(2)),
                      child: Image.network(
                        newsItem['imageUrl'],
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 200,
                            width: double.infinity,
                            color: Colors.grey[300],
                            child: const Icon(Icons.image,
                                size: 50, color: Colors.grey),
                          );
                        },
                      ),
                    ),
                  // NEWS CONTENT
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          newsItem['title'] ?? "No Title",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10.0),

                        Text(
                          newsItem['description'] ?? "No Description",
                          style:
                              TextStyle(fontSize: 14, color: Colors.grey[700]),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 10.0),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              newsItem['source'] ?? "Unknown Source",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),

                            Text(
                              controller.formatDate(
                                  newsItem['publishedAt']?.toString()),
                              // Use controller
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
