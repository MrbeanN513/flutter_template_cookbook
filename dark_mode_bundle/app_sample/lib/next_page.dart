import 'package:flutter/material.dart';

class Nextpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
//theme data onely work on materlai app

      //theme data for chance in app color(custom)>>>>>

      theme: ThemeData(
        //brightness.light for light theme>>>>>>>>
        brightness: Brightness.light,
      ),
      //for dark theme
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
//dark theme
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
              Text('$_counter', style: TextStyle(fontSize: 40.0)
                  //style theme colflict,only one theme data accepted>>>>>>>>>>>
                  // style: Theme.of(context).textTheme.display1,
                  ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
