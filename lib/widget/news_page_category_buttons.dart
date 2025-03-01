import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp/controller/news_controller.dart';

class CategoryButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const CategoryButton({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
      child: Obx(() {
        bool isDark = Get.find<NewsController>().isDarkMode.value;

        return ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: isDark ? Colors.white30 : Colors.white70,
            foregroundColor: isDark ? Colors.white : Colors.black,
            side: const BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
          child: Text(title),
        );
      }),
    );
  }
}
