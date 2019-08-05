import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("pate1 demo"),
      ),
      body: Container(
        child: Center(child: Text("page 1")),
      ),
    );
  }
}
