import 'package:code/Model/VideoPlayer_model.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayer_Provider extends ChangeNotifier {

  VideoPlayer_model v1 = VideoPlayer_model( );

  AddVideo(String path) async {
    v1.youtubePlayerController = YoutubePlayerController(
      initialVideoId: path,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        captionLanguage: "Jaynesh",
      ),
    );
    notifyListeners();
    }

  }

