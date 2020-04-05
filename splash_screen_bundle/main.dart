
// fisrt main.Dart
// second spash screen.Dart
// thrid nextpage

import 'package:flutter/material.dart';
import 'package:splash_screen/next_page.dart';
import 'package:splash_screen/splash_screen.dart';
//both are correct>>>>>>>>>>>>>

/// void main() => runApp(MyApp());

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      //debug banner on/off >>>>>>>>>>>>>
      debugShowCheckedModeBanner: false,

      /// splashcreen(class)................>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
      home: new SplashScreen(),

      /// route to next page................>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
      /// for route to next page always use that>>>>>>>>>>>>>>>>>>>>>>>>>>>>
      routes: <String, WidgetBuilder>{
        '/Nextpage': (BuildContext context) => Nextpage()
      },
    );
  }
}
