import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp/controller/news_controller.dart';

class CategoryButton extends StatelessWidget {
  final String title;

  const CategoryButton({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final NewsController controller = Get.find<NewsController>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
      child: Obx(() {
        bool isDark = controller.isDarkMode.value;
        bool isSelected = controller.selectedCategory.value == title;

        return ElevatedButton.icon(
          onPressed: () {
            controller.categorySelection(title);
          },
          icon: isSelected
              ? const Icon(Icons.check, color: Colors.white)
              : const SizedBox(width: 0),
          label: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : null,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: isSelected
                ? (isDark ? Colors.black : Colors.purple)
                : (isDark ? Colors.white30 : Colors.white70),
            foregroundColor: isDark ? Colors.white : Colors.black,
            side: const BorderSide(color: Colors.grey, width: 0.5),
          ),
        );
      }),
    );
  }
}
