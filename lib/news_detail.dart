import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp/model/news_model.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class NewsDetail extends StatelessWidget {
  final Article article;

  const NewsDetail({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.source?.name ?? "News Details",
            style: TextStyle(fontSize: 17.0)),
        backgroundColor: Get.isDarkMode ? Colors.black : Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {
                Share.share('Check out this news: https://example.com/news',
                    subject: 'Interesting News!');
              },
              icon: Icon(
                Icons.share,
                color: Colors.white,
              ))
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // News Image
            if (article.image != null && article.image!.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  article.image.toString(), // Ensuring it's a String
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 200,
                      width: double.infinity,
                      color: Colors.grey[300],
                      child: const Icon(Icons.broken_image,
                          size: 50, color: Colors.grey),
                    );
                  },
                ),
              ),
            const SizedBox(height: 10),

            // News Title
            Text(
              article.title?.toString() ?? "No Title", // Ensuring it's a String
              style:
                  const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20.0),

            // Date and Read More Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  article.publishedAt != null
                      ? DateFormat("MMMM d, yyyy")
                          .format(article.publishedAt!) // No need for parsing
                      : "Unknown Date",
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
                InkWell(
                  onTap: () async {
                    if (article.url != null && article.url!.isNotEmpty) {
                      final Uri url = Uri.parse(
                          article.url.toString()); // Ensuring it's a String
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url,
                            mode: LaunchMode.externalApplication);
                      } else {
                        Get.snackbar("Error", "Could not open the article",
                            snackPosition: SnackPosition.BOTTOM);
                      }
                    }
                  },
                  child: const Text(
                    "Read More",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff9d4edd),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 25.0),

            // News Description
            Text(
              article.description?.toString() ?? "No Description Available",
              // Ensuring it's a String
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),

            // Full News Content
            Text(
              article.content?.toString() ?? "No Additional Content Available",
              // Ensuring it's a String
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
