import 'dart:async';

import 'package:dataconnect/movie_state.dart';
import 'package:dataconnect/models/movie.dart';
import 'package:dataconnect/movies_connector/movies.dart';
import 'package:dataconnect/util/auth.dart';
import 'package:dataconnect/widgets/list_movies.dart';
import 'package:dataconnect/widgets/list_reviews.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile>
    with WidgetsBindingObserver, RouteAware {
  User? _currentUser;
  List<GetCurrentUserUserFavoriteMoviesMovie> _favoriteMovies = [];
  List<GetCurrentUserUserReviews> _reviews = [];
  String? _displayName;
  final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
  StreamSubscription<QueryResult<GetCurrentUserData, void>>? _listener;

  @override
  void initState() {
    super.initState();
    Auth.getCurrentUser().then((user) {
      if (mounted) {
        setState(() {
          _currentUser = user;
        });
      }
    });
    _listener = MovieState.subscribeToCurrentUser().listen((res) {
      if (mounted) {
        setState(() {
          _displayName = res.data.user!.name;
          _favoriteMovies =
              res.data.user!.favoriteMovies.map((e) => e.movie).toList();
          _reviews = res.data.user!.reviews;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _listener?.cancel();
  }

  _refresh() {
    MoviesConnector.instance.getCurrentUser().execute();
  }

  Widget _buildUserInfo() {
    return Container(
      child: Column(
        children: [
          Text('Welcome back ${_displayName ?? ''}!'),
          TextButton(
              onPressed: () async {
                FirebaseAuth.instance.signOut();
                context.go('/login');
              },
              child: Text('Sign out'))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _currentUser == null
        ? const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [CircularProgressIndicator()],
          )
        : RefreshIndicator(
            child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Container(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildUserInfo(),
                      ListMovies(
                          title: "Favorite Movies",
                          movies: _favoriteMovies
                              .map(
                                (e) => Movie(
                                    id: e.id,
                                    title: e.title,
                                    imageUrl: e.imageUrl),
                              )
                              .toList()),
                      ListReviews(
                          reviews: _reviews
                              .map(
                                (e) => Review(
                                    reviewText: e.reviewText!,
                                    rating: e.rating!,
                                    username: _currentUser!.email!,
                                    date: e.reviewDate),
                              )
                              .toList(),
                          title: "Reviews"),
                    ],
                  ),
                )),
            onRefresh: () async {
              await _refresh();
            });
  }
}
