import 'package:code/Controller/YoutubeVideo_Provider.dart';
import 'package:code/Model/Youtube_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Controller/VideoPlayer_Provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<YoutubeVideo_Provider>(context, listen: false)
          .searchVideo("Hello");
    });
  }

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    double h = s.height;
    double w = s.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Youtube",
            style: TextStyle(
              color: Colors.black,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          leading: Icon(
            Icons.menu,
            color: Colors.grey,
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.history,
                color: Colors.grey,
                size: 28,
              ),
            ),
          ],
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  onSubmitted: (val) {
                    Provider.of<YoutubeVideo_Provider>(context,listen: false).searchVideo(val);
                  },
                  decoration: InputDecoration(
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Colors.redAccent,
                        width: 3,
                      ),
                    ),
                  ),
                ),
                // Expanded(
                //   child: ListView.builder(
                //     itemBuilder: (context, index) => Container(),
                //   ),
                // ),
                SizedBox(
                  height: h * 0.02,
                ),
                Expanded(
                  child: FutureBuilder(
                      future: Provider.of<YoutubeVideo_Provider>(context)
                          .y1
                          .getVideo,
                      builder: (context, snapShot) {
                        if (snapShot.hasError) {
                          return Center(
                            child: Text("ERROR : ${snapShot.error}"),
                          );
                        } else if (snapShot.hasData) {
                          Youtube? data = snapShot.data;

                          return Container(
                            height: h,
                            width: w,
                            child: ListView.builder(
                              itemCount: data!.items.length,
                              itemBuilder: (context, i) => GestureDetector(
                                onTap: () {
                                  Provider.of<VideoPlayer_Provider>(context,
                                      listen: false)
                                      .AddVideo(data.items[i]['id']['videoId']);
                                  Navigator.of(context).pushNamed("VideoPlayerPage",arguments: data.items[i]);
                                },
                                child: Container(
                                  height: h * 0.25,
                                  width: double.infinity,
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                        image: NetworkImage(data.items[i]
                                                ['snippet']['thumbnails']['high']
                                            ['url']),
                                        fit: BoxFit.cover,
                                      )),
                                ),
                              ),
                            ),
                          );
                        }
                        return Center(child: CircularProgressIndicator());
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
