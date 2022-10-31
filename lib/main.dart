import 'package:flutter/material.dart';
import 'package:apirequest/beer/BeerUI.dart';
import 'package:apirequest/car/CarUI.dart';
import 'package:apirequest/car/CarUISingle.dart';
import 'package:apirequest/car/PostCar.dart';

import 'beer/BeerUI.dart';
import 'car/CarUI.dart';
import 'car/CarUISingle.dart';
import 'car/PostCar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController _controller = PageController(
    initialPage: 0,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: PageView(
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          controller: _controller,
          children: [BeerUI(), CarUI(), CarUISingle(), PostCar()],
        ));
  }
}
