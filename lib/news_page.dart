import 'package:flutter/material.dart';
import 'package:newsapp/widget/news_page_category_buttons.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "News App",
          style: TextStyle(fontSize: 27.0, color: Colors.white,fontFamily: 'Blinker'),
        ),
        backgroundColor: Colors.blueAccent,
        actions: [
          Icon(
            Icons.search,
            color: Colors.white,
          ),
        ],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                color: Colors.purple,
                width: double.infinity,
                height: 190.0,
                child: Column(
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
                    SizedBox(height: 5.0),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text("Home"),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.history),
                title: Text("Reading History"),
                onTap: () {},
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.sunny),
                title: Text("Dark Mode"),
                trailing: Switch(
                  value: false,
                  onChanged: (bool value) {},
                ),
                onTap: () {},
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

          //NEWS CONTENT BELOW
          Expanded(
            child: Center(
              child: Text("News Content Here"),
            ),
          ),
        ],
      ),
    );
  }
}
