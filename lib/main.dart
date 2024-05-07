import 'package:flutter/material.dart';
import 'package:wallpaper_youtube_akshit_madan/wallpaper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark),
      home: WallPaper(),
    );

    // This trailing comma makes auto-formatting nicer for build methods.
  }
}
