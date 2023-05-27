import 'package:code/Controller/VideoPlayer_Provider.dart';
import 'package:code/Controller/YoutubeVideo_Provider.dart';
import 'package:code/View/Screens/HomePage.dart';
import 'package:code/View/Screens/SplachScreen.dart';
import 'package:code/View/Screens/VideoPlayerPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {

  runApp(
   MultiProvider(providers: [
     ChangeNotifierProvider(create: (context)=> YoutubeVideo_Provider()),
     ChangeNotifierProvider(create: (context)=> VideoPlayer_Provider()),
   ],
     builder: (context, _) => MaterialApp(
       debugShowCheckedModeBanner: false,
       routes: {
         "/" :(context)=> SplachScreen(),
         "HomePage" :(context)=> HomePage(),
         "VideoPlayerPage" :(context)=> VideoPlayerPage(),
       },
     ) ,
   ),
  );
}