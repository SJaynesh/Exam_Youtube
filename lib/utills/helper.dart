import 'dart:convert';

import 'package:code/Model/Youtube_model.dart';
import 'package:http/http.dart' as http;

class APIHelper {
  APIHelper._();

  static final APIHelper apiHelper = APIHelper._();

  Future<Youtube?>fetchData(String search) async {
    String API =
        "https://www.googleapis.com/youtube/v3/search?key=AIzaSyBgm8BAE4mK8ZWh8qkwJpBXFcEOdWO_eCk&q=$search&type=video&part=snippet";

    http.Response res = await http.get(Uri.parse(API));

    if(res.statusCode == 200) {

      Map decodedData = jsonDecode(res.body);

      Youtube youtubeData = Youtube.formMap(data: decodedData);

      return youtubeData;
    }
  }
}
