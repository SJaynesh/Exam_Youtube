import 'package:code/Model/VideoPlayer_model.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoPlayer_Provider extends ChangeNotifier {

  VideoPlayer_model v1 = VideoPlayer_model( );

  AddVideo(String path) async {
    v1.videoPlayerController = VideoPlayerController.network("https://www.youtube.com/watch?v=${path}");

    await v1.videoPlayerController!.initialize();

    v1.chewieController = ChewieController(
      videoPlayerController: v1.videoPlayerController!,
      autoPlay: true,
      aspectRatio: 16 / 9,
    );
    notifyListeners();
  }

  StopVideo() async {
    await v1.videoPlayerController!.pause();
    notifyListeners();
  }
}
