import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaperhub/data/data.dart';
import 'package:wallpaperhub/model/wallpaper_model.dart';
import 'package:wallpaperhub/widgets.dart/widget.dart';

class Categories extends StatefulWidget {
  final String categories_Name;

  const Categories({Key key, this.categories_Name}) : super(key: key);
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<Wallpaper> wallpapers = new List();
  getSearchWallpaper(String query) async {
    var response = await http.get(
        "https://api.pexels.com/v1/search?query=$query&per_page=100",
        headers: {"Authorization": apiKey});
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach(
      (element) {
        Wallpaper wallpaper = new Wallpaper();
        wallpaper = Wallpaper.fromMap(element);
        wallpapers.add(wallpaper);
      },
    );
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSearchWallpaper(widget.categories_Name);
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
              SizedBox(
                height: 16,
              ),
              wallpaperlist(wallpapers: wallpapers, context: context),
            ],
          ),
        ),
      ),
    );
  }
}
