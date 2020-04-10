import 'package:flutter/material.dart';
import 'package:video/s.dart';
import 'package:flutter/services.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {  
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,

    
    
      title: 'Title',
      
      home: Video(),
    );
  }
}