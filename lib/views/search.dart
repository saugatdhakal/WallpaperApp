import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallpaperhub/data/data.dart';
import 'package:wallpaperhub/model/wallpaper_model.dart';
import 'package:wallpaperhub/widgets.dart/widget.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  final String searchQuery;

  Search({this.searchQuery});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<Wallpaper> wallpapers = new List();
  getSearchWallpaper(String query) async {
    var response = await http.get(
        "https://api.pexels.com/v1/search?query=$query&per_page=100",
        headers: {"Authorization": apiKey});
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element) {
      Wallpaper wallpaper = new Wallpaper();
      wallpaper = Wallpaper.fromMap(element);
      wallpapers.add(wallpaper);
    });
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getSearchWallpaper(widget.searchQuery);
    searchController.text = widget.searchQuery;
  }

  TextEditingController searchController = new TextEditingController();
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
                          GestureDetector(
                              onTap: () {
                                getSearchWallpaper(searchController.text);
                                wallpaperlist(
                                    wallpapers: wallpapers, context: context);
                              },
                              child: Container(child: Icon(Icons.search))),
                        ],
                      ),
                    )
                  ],
                ),
              ),
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
