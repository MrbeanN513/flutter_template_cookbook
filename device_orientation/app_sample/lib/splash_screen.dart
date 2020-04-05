import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override

//_SplashScreenState means its a private >>>>>>>>>>>>>>>>>>>>>>>>>>

  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //use of fdart:async package for timing >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

//route connection to main.dart >>>>>>>>>>>>>>>>>>>>>>>>>
  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/Nextpage');
  }
// statefull widget >>>>>>>>>>>>>>>
// for sefty use @override >>>>>>>>>>>>>>>>>>>>>>
// dart:async start timer >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        // asset photo >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
        child: new Image.asset('images/logo.png'),
      ),
    );
  }
}
