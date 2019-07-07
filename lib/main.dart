import 'package:flutter/material.dart';
import 'page_root.dart';
import 'page_auth.dart';

void main(){
  runApp(new MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Latihan 2',
      theme: new ThemeData(
        primarySwatch: Colors.blue
      ),
      home: new RootPage(auth: new Auth()),
    );
  }
}