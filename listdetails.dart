import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

void main() => runApp(list());

class list extends StatefulWidget {
  list({Key key}) : super(key: key);

  @override
  _listState createState() => _listState();
}

class _listState extends State<list> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listpage(),
    );
  }
}

class listpage extends StatefulWidget {
  listpage({Key key}) : super(key: key);

  @override
  _listpageState createState() => _listpageState();
}

class _listpageState extends State<listpage> {
  Future _data;
  Future getbaby() async {
    var firestore = Firestore.instance;
    QuerySnapshot gh = await firestore.collection('baby').getDocuments();
    return gh.documents;
  }

  navigatetodetails(DocumentSnapshot baby) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => details(baby: baby),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _data = getbaby();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
          child: FutureBuilder(
              future: _data,
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return Center(child: Text('loading...'));
                else {
                  return Scaffold(
                    appBar: AppBar(title: Text('FIRESTORE APP')),
                    body: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (_, index) {
                          return ListTile(
                              title: Text(snapshot.data[index].data['name']),
                              onTap: () =>
                                  navigatetodetails(snapshot.data[index]));
                        }),
                  );
                }
              })),
    );
  }
}

class details extends StatefulWidget {
  final DocumentSnapshot baby;
  details({this.baby});

  @override
  _detailsState createState() => _detailsState();
}

class _detailsState extends State<details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.baby.data['name']),
      ),
      body: Container(
          child: Card(
              child: ListTile(
        title: Text(widget.baby.data['name']),
        subtitle: Text(widget.baby.data['link']),
      ))),
    );
  }
}
