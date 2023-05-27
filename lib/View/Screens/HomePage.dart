import 'package:code/Controller/History_Provider.dart';
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
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<YoutubeVideo_Provider>(context, listen: false)
          .searchVideo("trailer");
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
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.lightBlueAccent.withOpacity(0.4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(60),
                    ),
                  ),
                  builder: (context) => DraggableScrollableSheet(
                      expand: false,
                      initialChildSize: 0.4,
                      maxChildSize: 0.9,
                      minChildSize: 0.32,
                      builder: (context, scrollController) => SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                              children: [
                                Text(
                                  "History",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                                Container(
                                  height: h,
                                  width: w,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 25, left: 16, right: 16, bottom: 30),
                                    child: ListView.builder(
                                      controller: scrollController,
                                      itemCount:
                                          Provider.of<History_Proivider>(context)
                                              .h1
                                              .History
                                              .length,
                                      itemBuilder: (context, i) => ListTile(
                                        title: Text(
                                          Provider.of<History_Proivider>(context)
                                              .h1
                                              .History[i],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        trailing: IconButton(
                                            onPressed: () {
                                              Provider.of<History_Proivider>(
                                                      context,
                                                      listen: false)
                                                  .deleteHistory(i);
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.limeAccent,
                                            )),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                      )),
                );
              },
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
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: searchController,
                  onSubmitted: (val) {
                    Provider.of<YoutubeVideo_Provider>(context, listen: false)
                        .searchVideo(val);
                    searchController.clear();
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
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Colors.greenAccent,
                        width: 3,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: h * 0.02,
              ),
              Expanded(
                child: FutureBuilder(
                    future:
                        Provider.of<YoutubeVideo_Provider>(context).y1.getVideo,
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
                            itemBuilder: (context, i) => Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Provider.of<VideoPlayer_Provider>(context,
                                            listen: false)
                                        .AddVideo(
                                            data.items[i]['id']['videoId']);
                                    Provider.of<History_Proivider>(context,
                                            listen: false)
                                        .addValueHistory(
                                            data.items[i]['snippet']['title']);
                                    Navigator.of(context).pushNamed(
                                        "VideoPlayerPage",
                                        arguments: data.items[i]);
                                  },
                                  child: Container(
                                    height: h * 0.35,
                                    width: w,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(data.items[i]
                                                ['snippet']['thumbnails']
                                            ['high']['url']),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                ListTile(
                                  title: Text(
                                    data.items[i]['snippet']['channelTitle'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(data.items[i]['snippet']
                                          ['publishTime']
                                      .toString()
                                      .split("T")[0]),
                                ),
                              ],
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
    );
  }
}
