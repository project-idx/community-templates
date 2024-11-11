import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app_clone/firebase_options.dart';
import 'package:movie_app_clone/generated/movie_connector.dart';
import 'package:movie_app_clone/login.dart';
import 'package:movie_app_clone/movie_detail_page.dart';

import 'error_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  int port = 443;
  String hostName = Uri.base.host;
  if (!kIsWeb) {
    hostName = '10.0.2.2';
    port = 9403;
  }
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    MovieConnectorConnector.instance.dataConnect
        .useDataConnectEmulator(hostName, port, isSecure: true);
    runApp(const MyApp());
  } catch (_) {
    runApp(const ShowError());
  }
}

final _router = GoRouter(
  routes: [
    GoRoute(
        path: '/login', builder: (context, state) => Login(), name: "Login"),
    GoRoute(
        path: '/movie-detail/:id',
        builder: (context, state) {
          return MovieDetailPage(id: state.pathParameters['id']!);
        },
        name: 'MovieDetail'),
    GoRoute(
        name: "Home",
        path: '/',
        builder: (context, state) => MyHomePage(
              title: "Home",
            ))
  ], // redirect to the login page if the user is not logged in
  redirect: (BuildContext context, GoRouterState state) async {
    // Using `of` method creates a dependency of StreamAuthScope. It will
    // cause go_router to reparse current route if StreamAuth has new sign-in
    // information.
    bool loggedIn = FirebaseAuth.instance.currentUser?.uid != null;
    if (loggedIn) {
      try {
        await FirebaseAuth.instance.currentUser!.getIdToken();
      } catch (_) {
        return '/login';
      }
    }
    final bool loggingIn = state.matchedLocation == '/login';
    if (!loggedIn) {
      return '/login';
    }

    // if the user is logged in but still on the login page, send them to
    // the home page
    if (loggingIn) {
      return '/';
    }

    // no need to redirect at all
    return null;
  },
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ListMoviesMovies> _movies = [];

  late ListMoviesMovies _currentMovie;

  bool showMessage = true;

  @override
  void initState() {
    super.initState();
    MovieConnectorConnector.instance.listMovies().ref().subscribe().listen(
        (res) {
      setState(() {
        _movies = res.data.movies;
        showMessage = res.data.movies.isEmpty;
      });
    }, onError: (_) {
      setState(() {
        showMessage = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
                padding: const EdgeInsets.all(15.0),
                child: showMessage
                    ? Column(children: [
                        Row(children: [
                          Text(
                              "Please Open the Firebase Data Connect Extension, Start Emulators, and Run moviedata_insert.gql Locally and then refresh the page.")
                        ]),
                      ])
                    : Column(
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
                            child: Row(
                              children: [
                                Icon(Icons.account_circle),
                                const SizedBox(width: 10),
                                Text(FirebaseAuth.instance.currentUser!.email!),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              SearchAnchor(builder: (BuildContext context,
                                  SearchController controller) {
                                return SearchBar(
                                  controller: controller,
                                  leading: Icon(Icons.search),
                                  onTap: () => controller.openView(),
                                  onChanged: (_) => controller.openView(),
                                  hintText: "Search for a movie",
                                );
                              }, suggestionsBuilder: (BuildContext context,
                                  SearchController controller) async {
                                List<ListTile> movies =
                                    await MovieConnectorConnector.instance
                                        .listMovies()
                                        .execute()
                                        .then(
                                          (value) => value.data.movies
                                              .map((e) => ListTile(
                                                  title: Text(e.title),
                                                  onTap: () {
                                                    setState(() {
                                                      _currentMovie = e;
                                                    });
                                                    controller
                                                        .closeView(e.title);
                                                  }))
                                              .toList(),
                                        );
                                return movies;
                                // print(movies.length);
                              }),
                              SizedBox(
                                height: 20,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Popular Movies",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                          Container(
                              width: double.infinity,
                              height: 320,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final movie = _movies[index];
                                  return GestureDetector(
                                      onTap: () => context.pushNamed(
                                          'MovieDetail',
                                          pathParameters: {'id': movie.id}),
                                      child: Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: Image.network(
                                              movie.imageUrl,
                                              height: 300.0,
                                              width: 200.0,
                                            ),
                                          ),
                                          Text(
                                            movie.title,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ));
                                },
                                itemCount: _movies.length,
                              )),
                        ],
                      ))));
  }
}
