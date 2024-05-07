import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_youtube_akshit_madan/full_screen_wallpaper.dart';

class WallPaper extends StatefulWidget {
  // const WallPaper({super.key});

  @override
  State<WallPaper> createState() => _WallPaperState();
}

class _WallPaperState extends State<WallPaper> {
  List images = [];
  int page_no = 1;

  @override
  void initState() {
    super.initState();
    fetchApi();
  }

  fetchApi() async {
    await http.get(Uri.parse('https://api.pexels.com/v1/curated?per_page=80'),
        headers: {
          'Authorization':
              'bDBisGhnAmttKJxssvKZm34pAVagNi8snE7iTKGRlFtAHfOhNHU0QAbj'
        }).then((value) {
      // print(
      //     'here is the responce you are waiting !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!' +
      //         value.body);

      Map results = jsonDecode(value.body);
      // log(results);
      // print(
      //     'here is result that we want to print *********************************************************************** ${results} ');

      images = results['photos'];
      setState(() {});
    });

    print(images);
    print('Number of Imags that i getting from the API is ${images.length}');
  }

  loadMore() async {
    setState(() {
      page_no = page_no + 1;

      print('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${page_no}');
    });

    String URL = 'https://api.pexels.com/v1/curated?per_page=80&page=' +
        page_no.toString();

    await http.get(Uri.parse(URL), headers: {
      'Authorization':
          'bDBisGhnAmttKJxssvKZm34pAVagNi8snE7iTKGRlFtAHfOhNHU0QAbj'
    }).then((value) {
      Map results = jsonDecode(value.body);

      images.addAll(results['photos']);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallpaper App'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
                child: GridView.builder(
                    itemCount: images.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 2,
                            childAspectRatio: 2 / 3,
                            mainAxisSpacing: 2),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FullScreenWallpaper(
                                      imageurl: images[index]['src']
                                          ['large2x'])));
                        },
                        child: Container(
                          child: Image.network(
                            images[index]['src']['tiny'],
                            fit: BoxFit.cover,
                          ),

                          // Text(
                          //   '${index}',
                          //   style: const TextStyle(color: Colors.black),
                          // ),

                          color: Colors.white,
                        ),
                      );
                    })),
          ),
          Container(
            height: 60,
            width: double.infinity,
            child: TextButton(
                onPressed: () {
                  loadMore();
                },
                child: const Text('Load More')),
          )
        ],
      ),
    );
  }
}
