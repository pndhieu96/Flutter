import 'package:flutter/material.dart';
import 'package:flutter_fetch_data/view/movie_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flurest',
      home: MovieScreen(),
    );
  }
}