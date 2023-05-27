import 'package:code/Controller/VideoPlayer_Provider.dart';
import 'package:code/Controller/YoutubeVideo_Provider.dart';
import 'package:code/Model/Youtube_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({Key? key}) : super(key: key);

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    double h = s.height;
    double w = s.width;
    Map data = ModalRoute.of(context)!.settings.arguments as Map;
    return SafeArea(
      child: Scaffold(
        body: YoutubePlayerBuilder(
            player: YoutubePlayer(
              controller: Provider.of<VideoPlayer_Provider>(context)
                  .v1
                  .youtubePlayerController!,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.amber,
            ),
            builder: (context, player) {
              return Column(
                children: [
                  player,
                  ListTile(
                    title: Text(
                      data['snippet']['title'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                          "${data['snippet']['channelTitle']} . ${data['snippet']['publishTime'].toString().split("T")[0]}.${data['snippet']['publishTime'].toString().split("T")[1].split("Z")[0]}"
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
