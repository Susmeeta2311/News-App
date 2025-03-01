import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp/controller/news_controller.dart';
import 'package:newsapp/news_reading_history_page.dart';
import 'package:newsapp/news_search_page.dart';
import 'package:newsapp/widget/news_page_category_buttons.dart';

class NewsPage extends GetView<NewsController> {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "News App",
          style: TextStyle(
              fontSize: 25.0, color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(NewsSearchPage());
            },
            icon: Icon(Icons.search, color: Colors.white),
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
                  Get.to(NewsReadingHistoryPage());
                },
              ),
              Divider(color: Theme.of(context).dividerColor),
              ListTile(
                leading: Obx(() {
                  bool isDark = Get.find<NewsController>().isDarkMode.value;
                  return Icon(
                    isDark ? Icons.nightlight_round : Icons.sunny,
                    color: isDark ? Colors.white70 : Colors.black,
                  );
                }),
                title: const Text("Dark Mode"),
                trailing: Obx(() => Switch(
                      value: Get.find<NewsController>().isDarkMode.value,
                      onChanged: (value) {
                        Get.find<NewsController>().onThemeClicked();
                      },
                    )),
                onTap: () {
                  controller.onThemeClicked();
                },
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
                CategoryButton(title: "General", onPressed: () {}),
                CategoryButton(title: "Business", onPressed: () {}),
                CategoryButton(title: "Technology", onPressed: () {}),
                CategoryButton(title: "Sports", onPressed: () {}),
                CategoryButton(title: "Entertainment", onPressed: () {}),
                CategoryButton(title: "Health", onPressed: () {}),
                CategoryButton(title: "Science", onPressed: () {}),
              ],
            ),
          ),
          // NEWS CONTENT BELOW
        ],
      ),
    );
  }
}
