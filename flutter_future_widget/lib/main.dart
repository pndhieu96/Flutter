import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Album {
  final int userId;
  final int id;
  final String title;

  Album({required this.userId, required this.id, required this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(userId: json['userId'], id: json['id'], title: json['title']);
  }
}

Future<Album> fetchAlbum(int id) async {
  final response =
      await http.get(Uri.https('jsonplaceholder.typicode.com', 'albums/$id'));
  if (response.statusCode == 200) {
    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int randomNumber = 1 + Random().nextInt(9);
  Future<Album>? futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum(randomNumber);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'FutureBuilder Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text('FutureBuilder Demo'),
          ),
          body: Center(
            child: RerunFutureBuilder(
                future: futureAlbum!, onRerun: () => {_runFuture()}),
          ),
        ));
  }

  void _runFuture() {
    randomNumber = 1 + Random().nextInt(9);
    futureAlbum = fetchAlbum(randomNumber);
    setState(() {});
  }
}

class RerunFutureBuilder extends StatelessWidget {
  final Future<Album> future;
  final Function onRerun;

  const RerunFutureBuilder({required this.future, required this.onRerun});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Center(
            child: Container(
                padding: const EdgeInsets.all(8.0),
                height: 100,
                alignment: Alignment.center,
                child: FutureBuilder<Album>(
                    future: future,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        } else if (snapshot.hasData) {
                          return Text(snapshot.data!.title);
                        }
                      }
                      return Container(
                        child: CircularProgressIndicator(),
                      );
                    })),
          ),
          GestureDetector(
            onTap: () {
              debugPrint('GestureDetector');
              onRerun.call();
            },
            child: Container(
              color: Colors.yellow.shade600,
              padding: const EdgeInsets.all(8),
              child: const Text('Reload'),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}
