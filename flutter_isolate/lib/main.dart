import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter/material.dart';

import 'package:flutter_isolate/isolate_page.dart';
import 'package:flutter_isolate/page1.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      routes: <String, WidgetBuilder>{
        // '/': (BuildContext context) => MyHomePage(),
        '/page1': (BuildContext context) => Page1(),
      },
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
  int result;
 IsolatePage isolatePage;
  @override
  initState() {
    super.initState();
     isolatePage = IsolatePage(context);

    IsolatePage.start();
    

  }

  bool status = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // if (!status) {
    // isolatePage.receivePortLister.listen((data) {

    //   print("receive ============" + data.toString());
    //   stdout.write('RECEIVE: ' + data.toString() + ', ');

    //   setState(() {
    //     result = data;
    //   });

    //   // if (data > 10) {
    //   //   Navigator.of(context).pushNamed('/page1');
    //   // }
    // });

    //   IsolatePage.start();

    //   status = true;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder<dynamic>(
                stream: isolatePage.stream,
                // initialData: 0,T
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  return Text('data from isolate ${snapshot.data} ');
                }),
            // Text(
            //   'data from isolate $result',
            // ),
            // FlatButton(
            //   onPressed: start,
            //   child: Text("start"),
            // ),
            // FlatButton(
            //   onPressed: stop,
            //   child: Text("stop"),
            // ),
          ],
        ),
      ),
    );
  }
}
