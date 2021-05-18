import 'package:flutter/material.dart';

void main() {
  runApp(Nav2App());
}

class Nav2App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: HomeScreen_AnonymousRouter(),

      // routes: {
      //   '/': (context) => HomeScreen_NamedRoutes(),
      //   '/details': (context) => DetailScreen(),
      // },

      onGenerateRoute: (settings) {
        if(settings.name == '/') {
          return MaterialPageRoute(builder: (context) => HomeScreen_NamedRoutes_With_onGenerateRoute());
        }

        var uri = Uri.parse(settings.name.toString());
        if(uri.pathSegments.length == 2 &&
          uri.pathSegments.first == 'details') {
          var id = uri.pathSegments[1];
          return MaterialPageRoute(builder: (context) => DetailScreen(id: id));
        }
        
        return MaterialPageRoute(builder: (context) => UnknownScreen());
      }
    );
  }
}

class HomeScreen_AnonymousRouter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: FlatButton(
          child: Text('View Details'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return DetailScreen(id: "1");
              })
            );
          },
        ),
      ),
    );
  }
}

class HomeScreen_NamedRoutes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: FlatButton(
          child: Text('View Details'),
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/details',
            );
          },
        ),
      ),
    );
  }
}

class HomeScreen_NamedRoutes_With_onGenerateRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: FlatButton(
          child: Text('View Details'),
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/details/1',
            );
          },
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  String id = "";

  DetailScreen({
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: FlatButton(
          child: Text('pop!'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

class UnknownScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('404!'),
      ),
    );
  }
}
