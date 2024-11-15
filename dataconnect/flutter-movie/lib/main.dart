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
  usePathUrlStrategy();
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
  bool _showMessage = true;

  @override
  void initState() {
    super.initState();

    MovieState.getTopTenMovies().then((res) {
      if (res.data.movies.isNotEmpty) {
        if (mounted) {
          setState(() {
            _showMessage = false;
            _topMovies = res.data.movies;
          });
        }
      }
    });

    MovieState.getTopTenMovies().then((res) {
      setState(() {
        _latestMovies = res.data.movies;
      });
    });
  }

  Widget _showMovie() {
    return Column(
      children: <Widget>[
        ListMovies(
            title: 'Top 10 Movies',
            movies: _topMovies
                .map(
                  (e) => Movie(id: e.id, title: e.title, imageUrl: e.imageUrl),
                )
                .toList()),
        ListMovies(
            title: 'Latest Movies',
            movies: _latestMovies
                .map(
                  (e) => Movie(id: e.id, title: e.title, imageUrl: e.imageUrl),
                )
                .toList()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: _showMessage
            ? Text(
                'Go to the Firebase Data Connect extension, and click start Emulators. Then run moviedata_insert.gql. Then, refresh the page.')
            : _showMovie(),
      )),
    );
  }
}
