import 'package:dataconnect/models/movie.dart';
import 'package:dataconnect/movie_state.dart';
import 'package:dataconnect/router.dart';
import 'package:dataconnect/widgets/list_movies.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'movies_connector/movies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  int port = 443;
  String hostName = Uri.base.host;
  if (!kIsWeb) {
    hostName = '10.0.2.2';
    port = 9403;
  }
  MoviesConnector.instance.dataConnect
      .useDataConnectEmulator(hostName, port, isSecure: true);
  FirebaseAuth.instance.useAuthEmulator('localhost', 9400);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData.dark(),
      routerConfig: router,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ListMoviesMovies> _topMovies = [];
  List<ListMoviesMovies> _latestMovies = [];

  @override
  void initState() {
    super.initState();

    MovieState.getTopTenMovies().then((res) {
      setState(() {
        _topMovies = res.data.movies;
      });
    });

    MovieState.getTopTenMovies().then((res) {
      setState(() {
        _latestMovies = res.data.movies;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ListMovies(
                title: 'Top 10 Movies',
                movies: _topMovies
                    .map(
                      (e) =>
                          Movie(id: e.id, title: e.title, imageUrl: e.imageUrl),
                    )
                    .toList()),
            ListMovies(
                title: 'Latest Movies',
                movies: _latestMovies
                    .map(
                      (e) =>
                          Movie(id: e.id, title: e.title, imageUrl: e.imageUrl),
                    )
                    .toList()),
          ],
        ),
      )),
    );
  }
}
