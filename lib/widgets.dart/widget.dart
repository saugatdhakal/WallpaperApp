import 'package:flutter/material.dart';
import 'package:wallpaperhub/model/wallpaper_model.dart';
import 'package:wallpaperhub/views/image_View.dart';

Widget brandName() {
  return RichText(
      text: TextSpan(
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          children: [
        TextSpan(text: 'Wallpaper', style: TextStyle(color: Colors.black87)),
        TextSpan(text: 'Hub', style: TextStyle(color: Colors.blue)),
      ]));
}

Widget wallpaperlist({List<Wallpaper> wallpapers, context}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
      padding: const EdgeInsets.all(4.0),
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 0.6,
      mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0,
      physics: ClampingScrollPhysics(),
      children: wallpapers.map((wallpaper) {
        return GridTile(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ImageView(imgUrl: wallpaper.src.portrait)));
            },
            child: Hero(
              tag: wallpaper.src.portrait,
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    wallpaper.src.portrait,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    ),
  );
}
