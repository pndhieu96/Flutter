import 'package:flutter/material.dart';

void main() {
  runApp(BooksApp());
}

class Book {
  final String title;
  final String author;

  Book(this.title, this.author);
}

class BooksApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BooksAppState();
}

class _BooksAppState extends State<BooksApp> {
  @override
  Widget build(BuildContext context) {
    BookRouterDelegate _routerDelegate = BookRouterDelegate();
    BookRouteInformationParser _routeInformationParser =
        BookRouteInformationParser();

    return MaterialApp.router(
      title: 'Books App',
      routerDelegate: _routerDelegate,
      routeInformationParser: _routeInformationParser,
    );
  }
}

class BookRoutePath {
  final int id;
  final bool isUnknown;

  BookRoutePath.home()
      : id = -1,
        isUnknown = false;

  BookRoutePath.deatils(this.id) : isUnknown = false;

  BookRoutePath.unknown()
      : id = -1,
        isUnknown = true;

  bool get isHomePage => id == -1;

  bool get isDeatilsPage => id != -1;
}

class BookRouterDelegate extends RouterDelegate<BookRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BookRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;

  Book _selectedBook = Book("", "");
  bool show404 = false;
  List<Book> books = [
    Book('Left Hand of Darkness', 'Ursula K. Le Guin'),
    Book('Too Like the Lightning', 'Ada Palmer'),
    Book('Kindred', 'Octavia E. Butler'),
  ];

  BookRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  TransitionDelegate transitionDelegate = NoAnimationTransitionDelegate();

  BookRoutePath get currentConfiguration {
    debugPrint("BookRouterDelegate: get currentConfiguration - Init Navigator");
    if (show404) {
      return BookRoutePath.unknown();
    }
    return _selectedBook.title.isEmpty
        ? BookRoutePath.home()
        : BookRoutePath.deatils(books.indexOf(_selectedBook));
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("BookRouterDelegate: build() - Init Navigator");
    return Navigator(
      key: navigatorKey,
      transitionDelegate: transitionDelegate,
      pages: [
        MaterialPage(
          key: ValueKey('BooksListPage'),
          child: BooksListScreen(
            books: books,
            onTapped: _handleBookTapped,
          ),
        ),
        if (show404)
          MaterialPage(key: ValueKey('UnknownPage'), child: UnknownScreen())
        else if (_selectedBook.title.isNotEmpty)
          BookDetailsPage(book: _selectedBook)
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        debugPrint("BookRouterDelegate: build() - onPopPage - pop event");
        // Update the list of pages by setting _selectedBook to null
        _selectedBook = Book("", "");
        show404 = false;
        notifyListeners();

        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(BookRoutePath path) async {
    debugPrint("BookRouterDelegate: setNewRoutePath()");

    if (path.isUnknown) {
      _selectedBook = Book("", "");
      show404 = true;
      return;
    }

    if (path.isDeatilsPage) {
      if (path.id < 0 || path.id > books.length - 1) {
        show404 = true;
        return;
      }

      _selectedBook = books[path.id];
    } else {
      _selectedBook = Book("", "");
    }

    show404 = false;
  }

  void _handleBookTapped(Book book) {
    debugPrint("BookRouterDelegate: _handleBookTapped()");

    _selectedBook = book;
    notifyListeners();
  }
}

class BookRouteInformationParser extends RouteInformationParser<BookRoutePath> {
  @override
  Future<BookRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    var uri = Uri.parse("/");
    if (routeInformation.location != null) {
      uri = Uri.parse(routeInformation.location!);
    }
    debugPrint("BookRouteInformationParser: $uri");
    // Handle '/'
    if (uri.pathSegments.length == 0) {
      return BookRoutePath.home();
    }

    // Handle '/book/:id'
    if (uri.pathSegments.length == 2) {
      if (uri.pathSegments[0] != 'book') return BookRoutePath.unknown();
      var remaining = uri.pathSegments[1];
      var id = int.tryParse(remaining);
      if (id == null) return BookRoutePath.unknown();
      return BookRoutePath.deatils(id);
    }

    // Handle unknown routes
    return BookRoutePath.unknown();
  }

  @override
  RouteInformation? restoreRouteInformation(BookRoutePath path) {
    // TODO: implement restoreRouteInformation
    if (path.isUnknown) {
      return RouteInformation(location: '/404');
    }
    if (path.isHomePage) {
      debugPrint(
          "BookRouteInformationParser: restoreRouteInformation() isHomePage");
      return RouteInformation(location: '/');
    }
    if (path.isDeatilsPage) {
      debugPrint(
          "BookRouteInformationParser: restoreRouteInformation() isDeatilsPage");
      return RouteInformation(location: '/book/${path.id}');
    }
    return null;
  }
}

class NoAnimationTransitionDelegate extends TransitionDelegate<void> {
  @override
  Iterable<RouteTransitionRecord> resolve(
      {required List<RouteTransitionRecord> newPageRouteHistory,
      required Map<RouteTransitionRecord?, RouteTransitionRecord>
          locationToExitingPageRoute,
      required Map<RouteTransitionRecord?, List<RouteTransitionRecord>>
          pageRouteToPagelessRoutes}) {
    final results = <RouteTransitionRecord>[];

    for (final pageRoute in newPageRouteHistory) {
      if (pageRoute.isWaitingForEnteringDecision) {
        pageRoute.markForAdd();
      }

      results.add(pageRoute);
    }

    for (final exitingPageRoute in locationToExitingPageRoute.values) {
      if (exitingPageRoute.isWaitingForExitingDecision) {
        exitingPageRoute.markForRemove();
        final pagelessRoutes = pageRouteToPagelessRoutes[exitingPageRoute];
        if (pagelessRoutes != null) {
          for (final pagelessRoute in pagelessRoutes) {
            pagelessRoute.markForRemove();
          }
        }
      }

      results.add(exitingPageRoute);
    }

    return results;
  }
}

class BooksListScreen extends StatelessWidget {
  final List<Book> books;
  final ValueChanged<Book> onTapped;

  BooksListScreen({
    required this.books,
    required this.onTapped,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint("BooksListScreen: build()");
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          for (var book in books)
            ListTile(
              title: Text(book.title),
              subtitle: Text(book.author),
              onTap: () => onTapped(book),
            )
        ],
      ),
    );
  }
}

class BookDetailsPage extends Page {
  final Book book;

  BookDetailsPage({
    required this.book,
  }) : super(key: ValueKey(book));

  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (context, animation, animation2) {
        final tween = Tween(begin: Offset(0.0, 1.0), end: Offset.zero);
        final curveTween = CurveTween(curve: Curves.easeInOut);
        return SlideTransition(
          position: animation.drive(curveTween).drive(tween),
          child: BookDetailsScreen(
            key: ValueKey(book),
            book: book,
          ),
        );
      },
    );
  }
}

class BookDetailsScreen extends StatelessWidget {
  final Book book;
  final Key key;

  BookDetailsScreen({
    required this.book,
    required this.key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (book != null) ...[
              Text(book.title, style: Theme.of(context).textTheme.headline6),
              Text(book.author, style: Theme.of(context).textTheme.subtitle1),
            ],
          ],
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
