



import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body:StreamBuilder(
          stream: Firestore.instance.collection('baby').snapshots(),
          
          builder: (BuildContext context,  snapshot){
             if (!snapshot.hasData) return CircularProgressIndicator();

        return  SingleChildScrollView(
                  child: Column(children: <Widget>[
                
                FloatingActionButton(child:Text('duckduckgo',style: TextStyle(fontSize: 50.0),),  onPressed:(){launch(snapshot.data.documents[3]['url']);}),
              ],),
        );
          },
        ),
      ),
    );
  }
}

