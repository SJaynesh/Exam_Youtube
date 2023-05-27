import 'package:code/Controller/History_Provider.dart';
import 'package:code/Controller/VideoPlayer_Provider.dart';
import 'package:code/Controller/YoutubeVideo_Provider.dart';
import 'package:code/Model/History_Model.dart';
import 'package:code/View/Screens/HomePage.dart';
import 'package:code/View/Screens/SplachScreen.dart';
import 'package:code/View/Screens/VideoPlayerPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences Pref = await SharedPreferences.getInstance();

  List<String> history = Pref.getStringList("History") ?? [];

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => YoutubeVideo_Provider()),
        ChangeNotifierProvider(create: (context) => VideoPlayer_Provider()),
        ChangeNotifierProvider(
            create: (context) =>
                History_Proivider(h1: History_Model(History: history))),
      ],
      builder: (context, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          "/": (context) => SplachScreen(),
          "HomePage": (context) => HomePage(),
          "VideoPlayerPage": (context) => VideoPlayerPage(),
        },
      ),
    ),
  );
}
