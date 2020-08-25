import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallpaperhub/data/data.dart';
import 'package:wallpaperhub/model/categories_model.dart';
import 'package:wallpaperhub/model/wallpaper_model.dart';
import 'package:wallpaperhub/views/categorie.dart';
import 'package:wallpaperhub/views/image_View.dart';
import 'package:wallpaperhub/views/search.dart';
import 'package:wallpaperhub/widgets.dart/widget.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<CategoriesModel> categories = new List();
  List<Wallpaper> wallpapers = new List();
  TextEditingController searchController = new TextEditingController();

  getTrandingWallpaper() async {
    var response = await http.get(
        "https://api.pexels.com/v1/curated?per_page=15",
        headers: {"Authorization": apiKey});
    //print(response.body.toString());

    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element) {
      //print(element);
      Wallpaper wallpaperobj = new Wallpaper();
      wallpaperobj = Wallpaper.fromMap(element);
      wallpapers.add(wallpaperobj);
    });
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getTrandingWallpaper();
    categories = getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: brandName(),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              //*Searching Codes start
              Container(
                decoration: BoxDecoration(
                  color: Color(0xfff5f8fd),
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: searchController,
                              decoration: InputDecoration(
                                  hintText: "search wallpapers",
                                  border: InputBorder.none),
                            ),
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Search(
                                      searchQuery: searchController.text,
                                    ),
                                  ),
                                );
                              },
                              child: Container(child: Icon(Icons.search))),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              //*Searching Code Ends
              SizedBox(
                height: 16.0,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Made By",
                      style: TextStyle(fontSize: 12.0),
                    ),
                    Text(
                      "Saugat Dhakal",
                      style: TextStyle(color: Colors.blue, fontSize: 12.0),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                height: 80,
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: ListView.builder(
                    itemCount: categories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return CategoriesTile(
                        imgUrl: categories[index].imgUrl,
                        title: categories[index].categoriesName,
                      );
                    }),
              ),
              SizedBox(
                height: 16,
              ),
              wallpaperlist(wallpapers: wallpapers, context: context)
            ],
          ),
        ),
      ),
    );
  }
}

class CategoriesTile extends StatelessWidget {
  final String imgUrl;
  final String title;

  const CategoriesTile({Key key, this.imgUrl, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Categories(
                      categories_Name: title.toLowerCase(),
                    )));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 6),
        child: Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imgUrl,
                  height: 50,
                  width: 100,
                  fit: BoxFit.cover,
                )),
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              alignment: Alignment.center,
              height: 50,
              width: 100,
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }
}
