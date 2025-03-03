import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp/controller/news_controller.dart';
import 'package:share_plus/share_plus.dart';

class NewsSearchPage extends GetView<NewsController> {
  const NewsSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: "Search news...",
            hintStyle: TextStyle(color: Colors.grey),
            border: InputBorder.none,
          ),
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Get.isDarkMode ? Color(0xff343a40) : Colors.blueAccent,
        iconTheme:IconThemeData(color: Colors.white),
        actions:  [
         Icon(Icons.clear,color: Colors.white),
        ],
      ),
     body: Center(child: Column(
       mainAxisSize: MainAxisSize.min,
       children: [
         Icon(Icons.search,size: 70.0,color: Colors.grey,),
         SizedBox(height: 10.0),
         Text(
           "Search for news",
           style: TextStyle(fontSize: 18, color: Colors.grey),
         ),
       ],
     ),),
    );
  }
}
