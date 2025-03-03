import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp/controller/news_controller.dart';

class NewsReadingHistoryPage extends GetView<NewsController> {
  const NewsReadingHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: "Reading History",
            hintStyle: TextStyle(color: Colors.white, fontSize: 22.0),
            border: InputBorder.none,
          ),
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Get.isDarkMode ? Color(0xff343a40) : Colors.blueAccent,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.delete_outline_outlined, color: Colors.white))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.history,
              size: 70.0,
              color: Colors.grey,
            ),
            SizedBox(height: 10.0),
            Text(
              "No reading history",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
