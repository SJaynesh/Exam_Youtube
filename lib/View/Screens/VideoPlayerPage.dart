import 'package:code/Controller/VideoPlayer_Provider.dart';
import 'package:code/Model/Youtube_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

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
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                height: h * 0.3,
                width: w,
                color: Colors.blue,
                child: AspectRatio(
                  aspectRatio:
                      Provider.of<VideoPlayer_Provider>(context, listen: true)
                          .v1
                          .videoPlayerController!
                          .value
                          .aspectRatio,
                  child: Chewie(
                      controller: Provider.of<VideoPlayer_Provider>(context,
                              listen: true)
                          .v1
                          .chewieController!),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
