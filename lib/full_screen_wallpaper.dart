import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';

class FullScreenWallpaper extends StatefulWidget {
  FullScreenWallpaper({required this.imageurl});

  final String imageurl;

  @override
  State<FullScreenWallpaper> createState() => _FullScreenWallpaperState();
}

class _FullScreenWallpaperState extends State<FullScreenWallpaper> {
  Future<void> setWallpaper() async {
    int location = WallpaperManager.HOME_SCREEN;
    var file = await DefaultCacheManager().getSingleFile(widget.imageurl);

    bool result =
        await WallpaperManager.setWallpaperFromFile(file.path, location);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
                child: Container(
              child: Image.network(widget.imageurl),
            )),
            Container(
              height: 60,
              width: double.infinity,
              child: TextButton(
                  onPressed: () {
                    setWallpaper();
                  },
                  child: const Text('Set Full Screen Wallpaper')),
            )
          ],
        ),
      ),
    );
  }
}
