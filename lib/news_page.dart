import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp/controller/news_controller.dart';
import 'package:newsapp/model/news_model.dart';
import 'package:newsapp/news_detail.dart';
import 'package:newsapp/news_reading_history_page.dart';
import 'package:newsapp/news_search_page.dart';
import 'package:newsapp/widget/news_page_category_buttons.dart';

class NewsPage extends GetView<NewsController> {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "News App",
          style: TextStyle(fontSize: 25.0, color: Colors.white),
        ),
        backgroundColor: Get.isDarkMode ? const Color(0xff343a40) : Colors.blueAccent,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(const NewsSearchPage());
            },
            icon: const Icon(Icons.search, color: Colors.white),
          )
        ],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Column(
            children: [
              Container(
                color: Theme.of(context).primaryColor,
                width: double.infinity,
                height: 190.0,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      " News App",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 27.0,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      "  Stay informed",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 7.0),
                  ],
                ),
              ),
              ListTile(
                leading:
                Icon(Icons.home, color: Theme.of(context).iconTheme.color),
                title: const Text("Home"),
                onTap: () {
                  Get.back();
                },
              ),
              ListTile(
                leading: const Icon(Icons.history),
                title: const Text("Reading History"),
                onTap: () {
                  Get.to(const NewsReadingHistoryPage());
                },
              ),
              Divider(color: Theme.of(context).dividerColor),
              ListTile(
                leading: Obx(() {
                  bool isDark = controller.isDarkMode.value;
                  return Icon(
                    isDark ? Icons.nightlight_round : Icons.sunny,
                    color: isDark ? Colors.white70 : Colors.black,
                  );
                }),
                title: const Text("Dark Mode"),
                trailing: Obx(() => Switch(
                  value: controller.isDarkMode.value,
                  onChanged: (value) {
                    controller.onThemeClicked();
                  },
                )),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // NEWS CATEGORY BUTTONS
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                CategoryButton(title: "General"),
                CategoryButton(title: "Business"),
                CategoryButton(title: "Technology"),
                CategoryButton(title: "Sports"),
                CategoryButton(title: "Entertainment"),
                CategoryButton(title: "Health"),
                CategoryButton(title: "Science"),
              ],
            ),
          ),
          // NEWS CONTENT BELOW
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.articles.isEmpty) {
                return const Center(child: Text("No news available"));
              }
              return ListView.builder(
                itemCount: controller.articles.length,
                itemBuilder: (context, index) {
                  final article = controller.articles[index];
                  return GestureDetector(
                    onTap: () {
                      // Add news to reading history when clicked
                      controller.addToHistory(
                        article.title ?? "No Title",
                        article.description ?? "No Description",
                        article.url ?? "",
                        article.image ?? "",
                        article.publishedAt.toString()?? "",
                      );
                      Get.to(() => NewsDetail(article: article));
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 8.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // IMAGE
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(2)),
                            child: Image.network(
                              article.image ?? "https://via.placeholder.com/200",
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
                                // **News Title**
                                Text(
                                  article.title ?? "No Title",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                // **News Description**
                                Text(
                                  article.description ?? "No Description",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey[700]),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 10.0),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    // News Source (Left Side)
                                    Text(
                                      article.source?.name ?? "Unknown Source",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                      ),
                                    ),

                                    // Published Date (Right Side)
                                    Text(
                                      controller
                                          .formatDate(article.publishedAt),
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[700]),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
