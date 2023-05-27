import 'package:code/Model/YoutubeVideo_model.dart';
import 'package:flutter/cupertino.dart';

import '../utills/helper.dart';

class YoutubeVideo_Provider extends ChangeNotifier {

  YoutubeVideo_Model y1 = YoutubeVideo_Model(null, []);

  searchVideo(val) {
    Future.delayed(Duration.zero,(){
      y1.getVideo = APIHelper.apiHelper.fetchData(val);
    });

    notifyListeners();
  }
}