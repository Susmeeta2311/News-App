import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp/controller/news_controller.dart';
import 'package:newsapp/news_page.dart';

void main() {
  Get.put(NewsController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final NewsController controller = Get.find();

    return Obx(() => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter News App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            // fontFamily: 'Roboto'
          ),
          darkTheme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.deepPurple, brightness: Brightness.dark),
          ),
          themeMode:
              controller.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
          //
      initialBinding: BindingsBuilder(() {
        //IT WILL ALLOCATE MEMORY AT THE STARTING OF THE APPLICATION
        Get.put(NewsController()); // DEPENDENCY INJECTION
      }
      ),

          home: const NewsPage(),
        ));
  }
}
